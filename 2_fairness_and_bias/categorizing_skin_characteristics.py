import argparse
import logging
import pathlib
import functools

import cv2
import math
import numpy as np
from skimage import color
import torch
from torchvision import transforms

from semantic_segmentation import models
from semantic_segmentation import load_model
from semantic_segmentation import draw_results

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--images', type=str, required=True)
    parser.add_argument('--model', type=str, required=True)

    parser.add_argument('--model-type', type=str, choices=models, required=True)

    parser.add_argument('--threshold', type=float, default=0.5)

    parser.add_argument('--save', action='store_true')
    parser.add_argument('--display', action='store_true')

    return parser.parse_args()


def find_files(dir_path: pathlib.Path, file_exts):
    assert dir_path.exists()
    assert dir_path.is_dir()

    for file_ext in file_exts:
        yield from dir_path.rglob(f'*{file_ext}')


def _load_image(image_path: pathlib.Path):
    image = cv2.imread(str(image_path))
    assert image is not None

    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    image_width = (image.shape[1] // 32) * 32
    image_height = (image.shape[0] // 32) * 32

    image = image[:image_height, :image_width]
    return image


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    args = parse_args()

    device = 'cuda' if torch.cuda.is_available() else 'cpu'
    logging.info(f'running inference on {device}')

    assert args.display or args.save

    logging.info(f'loading {args.model_type} from {args.model}')
    model = torch.load(args.model, map_location=device)
    model = load_model(models[args.model_type], model)
    model.to(device).eval()

    logging.info(f'evaluating images from {args.images}')
    image_dir = pathlib.Path(args.images)

    fn_image_transform = transforms.Compose(
        [
            transforms.Lambda(lambda image_path: _load_image(image_path)),
            transforms.ToTensor(),
            transforms.Normalize(mean=(0.485, 0.456, 0.406), std=(0.229, 0.224, 0.225)),
        ]
    )

    for image_file in find_files(image_dir, ['.png', '.jpg', '.jpeg']):
        logging.info(f'segmenting {image_file} with threshold of {args.threshold}')

        image = fn_image_transform(image_file)

        with torch.no_grad():
            image = image.to(device).unsqueeze(0)
            results = model(image)['out']
            results = torch.sigmoid(results)

            results = results > args.threshold

        # get only the rgb2lta
        for category, category_image, mask_image in draw_results(image[0], results[0], categories=model.categories):
            mask_image_rgb = cv2.cvtColor(mask_image, cv2.COLOR_BGR2RGB)
            skin_rgb_vals = mask_image_rgb.nonzero()
            skin_vals = list(set(zip(skin_rgb_vals[0], skin_rgb_vals[1])))
            lab_vals = color.rgb2lab([mask_image_rgb[x][y] for x,y in skin_vals])
            ita_vals = [ np.arctan((l_val - 50) / float(b_val)) * (180/ math.pi) for l_val, _, b_val in lab_vals]
            print("For image %s" % image_file)
            print("Mean ITA value %s" % np.mean(ita_vals))
            print("Mean ITA value %s" % np.median(ita_vals))
            print("saving images for skin detection to view")
            if args.save:
                output_name = f'results_{category}_{image_file.name}'
                logging.info(f'writing output to {output_name}')
                cv2.imwrite(str(output_name), category_image)
                cv2.imwrite(f'mask_{category}_{image_file.name}', mask_image)
