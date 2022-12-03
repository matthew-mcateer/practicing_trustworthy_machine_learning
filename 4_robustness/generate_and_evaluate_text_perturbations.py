import torch
from nltk.corpus import wordnet as wn
from transformers import GPT2Tokenizer, GPT2LMHeadModel
import math
from transformers import BertModel, BertConfig, BertTokenizer
from numpy import dot
from numpy.linalg import norm
import random 
import spacy
nlp = spacy.load("en_core_web_sm")

tokenizer = GPT2Tokenizer.from_pretrained("gpt2")
model = GPT2LMHeadModel.from_pretrained("gpt2")
model.eval()

def get_perturbations(sentence, constraint):
	orig_sentence = sentence
	tokens = sentence.split(' ')
	num_to_replace = random.randint(1, len(tokens))
	blob = TextBlob(sentence)
	nouns = [n for n,t in blob.tags if 'NN' in t]
	print(nouns)
	for noun in nouns:
		for synonym in wn.synsets(noun):
			synonym = synonym.lemma_names()[0]
			print(synonym)
			if synonym != noun:
				if "_" in synonym:
					synonym = synonym.split("_")[1]
				sentence = sentence.replace(noun, synonym)
				break
	print(sentence)
	if get_fluency_score(orig_sentence) - get_fluency_score(sentence) < 30:
		return sentence
	return orig_sentence

def cosine_similarity(a, b):
	return dot(a, b)/(norm(a)*norm(b))

def get_fluency_score(text):
    input_ids = torch.tensor(tokenizer.encode(text)).unsqueeze(0)
    with torch.no_grad():
        outputs = model(input_ids, labels=input_ids)
    loss, _ = outputs[:2] 
    perplexity = math.exp(loss.item()) 
    return perplexity

def get_similarity(sentence, paraphrase):
	model = BertModel.from_pretrained("bert-base-cased")
	tokenizer = BertTokenizer.from_pretrained("bert-base-cased")
	input_1 = tokenizer(sentence, return_tensors="pt")
	outputs_1 = model(**input_1)
	last_hidden_states_1 = outputs_1.last_hidden_state
	input_2 = tokenizer(paraphrase, return_tensors="pt")
	outputs_2 = model(**input_2)
	last_hidden_states_2 = outputs_2.last_hidden_state
	# Get CLS token state
	cls_1, cls_2 = last_hidden_states_1[0][0], last_hidden_states_2[0][0]
	print(cls_1.size())
	return cosine_similarity(cls_1.tolist(), cls_2.tolist())
