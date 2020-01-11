#!/bin/bash

vocab_size=full
norder=5

python engines/ngram/create_vocab.py \
	--train_file data/twitter/train_clean_${vocab_size}.txt \
	--vocab_file engines/ngram/models/twitter_${vocab_size}.vocab


ngram-count -vocab engines/ngram/models/twitter_${vocab_size}.vocab \
	-text data/twitter/train_clean_${vocab_size}.txt \
	-order ${norder} \
	-write engines/ngram/models/twitter_${vocab_size}.count \
	-unk

ngram-count \
	-vocab engines/ngram/models/twitter_${vocab_size}.vocab \
	-read engines/ngram/models/twitter_${vocab_size}.count \
	-order ${norder} \
	-lm engines/ngram/models/twitter_${vocab_size}.${norder}.lm \
	-kndiscount1 \
	-kndiscount2 \
	-kndiscount3 \
	-kndiscount4 \
	-kndiscount5

ngram \
	-ppl data/twitter/valid_clean.txt \
	-order 1 \
	-lm engines/ngram/models/twitter_${vocab_size}.${norder}.lm

ngram \
	-ppl data/twitter/valid_clean.txt \
	-order 2 \
	-lm engines/ngram/models/twitter_${vocab_size}.${norder}.lm

ngram \
	-ppl data/twitter/valid_clean.txt \
	-order 3 \
	-lm engines/ngram/models/twitter_${vocab_size}.${norder}.lm

ngram \
	-ppl data/twitter/valid_clean.txt \
	-order 4 \
	-lm engines/ngram/models/twitter_${vocab_size}.${norder}.lm

ngram \
	-ppl data/twitter/valid_clean.txt \
	-order 5 \
	-lm engines/ngram/models/twitter_${vocab_size}.${norder}.lm