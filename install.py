import subprocess
import sys

def check_if_colab() -> bool:
    """Check if this is being run in Google Colab."""
    return "google.colab" in sys.modules

def check_if_kaggle() -> bool:
    """Check if this is being run in Kaggle."""
    return "kaggle_secrets" in sys.modules

IS_COLAB = check_if_colab()
IS_KAGGLE = check_if_kaggle()


class RequirementsInstallError(Exception):
    def __init__(self, message):
        self.message = message
    def __str__(self):
        return self.message


def install_requirements(
    is_chapter0: bool = False, 
    is_chapter1: bool = False, 
    is_chapter1_v2: bool = False, 
    is_chapter2: bool = False, 
    is_chapter3: bool = False,
    is_chapter4: bool = False,
    is_chapter5: bool = False,
    is_chapter6: bool = False,
    is_chapter7: bool = False,
    ):
    """Installs the required packages for the project."""

    print("⏳ Installing base requirements ...")
    cmd = ["python", "-m", "pip", "install", "-r"]
    if is_chapter0:
        cmd.append("0_introduction/requirements-chapter0.txt")
    elif is_chapter1:
        cmd += "1_privacy/requirements-chapter1.txt -f https://download.pytorch.org/whl/torch_stable.html".split()
    elif is_chapter1_v2:
        cmd.append("1_privacy/requirements-chapter1-v2.txt")
    elif is_chapter2:
        cmd.append("2_fairness_and_bias/requirements-chapter2.txt")
    elif is_chapter3:
        cmd.append("3_model_explainability_and_interpretability/requirements-chapter3.txt")
    elif is_chapter4:
        cmd.append("4_robustness/requirements-chapter4.txt")
    elif is_chapter5:
        cmd.append("5_secure_and_trustworthy_data_generation/requirements-chapter5.txt")
    elif is_chapter6:
        cmd.append("6_more_state_of_the_art_research_questions/requirements-chapter6.txt")
    elif is_chapter7:
        cmd.append("7_from_theory_to_practice/requirements-chapter7.txt")
    else:
        cmd.append("requirements.txt")
    process_install = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if process_install.returncode != 0:
        raise RequirementsInstallError("😭 Failed to install base requirements")
    else:
        print("✅ Base requirements installed!")
    
    print("⏳ Installing Git LFS ...")
    process_lfs = subprocess.run(["apt", "install", "git-lfs"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if process_lfs.returncode == -1:
        raise RequirementsInstallError("😭 Failed to install Git LFS and soundfile")
    else:
        print("✅ Git LFS installed!")

    if is_chapter2:
        transformers_cmd = "python -m pip install transformers==4.13.0".split()
        _ = subprocess.run(
            transformers_cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )

    if is_chapter5:
        transformers_cmd = "python -m pip install datasets==2.0.0".split()
        _ = subprocess.run(
            transformers_cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )

    if is_chapter6:
        wandb_cmd = "python -m pip install wandb".split()
        _ = subprocess.run(
            wandb_cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
    print("🥳 Chapter installation complete!")
