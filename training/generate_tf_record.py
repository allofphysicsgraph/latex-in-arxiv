import tensorflow as tf
from transformers import (
    BertTokenizerFast,
)  # For a basic BERT tokenizer (replace with yours)
import random

# 1. Define a Very Simple Vocabulary (Illustrative - Replace with your
# vocab.txt)
vocab_list = [
    "[PAD]",
    "[UNK]",
    "[CLS]",
    "[SEP]",
    "[MASK]",
    "documentclass",
    "article",
    "usepackage",
    "graphicx",
    "begin",
    "document",
    "section",
    "introduction",
    "text",
    "equation",
    "frac",
    "1",
    "2",
    "alpha",
    "beta",
    "end",
    "abstract",
]
vocab_file = "simple_vocab.txt"  # Save this vocab to a file for the tokenizer
with open(vocab_file, "w", encoding="utf-8") as f:
    for token in vocab_list:
        f.write(token + "\n")

tokenizer = BertTokenizerFast(vocab_file=vocab_file)

# 2. Simple LaTeX Document Example (String - Replace with reading from
# your LaTeX files)
latex_document = r"""
\documentclass{article}
\usepackage{graphicx}
\begin{document}
\section{Introduction}
This is some text with an equation:
\begin{equation}
E = mc^2
\end{equation}
\end{document}
"""

# 3. Configuration Parameters
max_seq_length = 128  # Example max sequence length
max_predictions_per_seq = 20  # Example max masked tokens per sequence
masking_probability = 0.15  # 15% masking probability for MLM
output_tfrecord_file = "latex_example.tfrecord"

# 4. Tokenization and Integer ID Conversion
tokens = tokenizer.tokenize(latex_document)
input_ids = tokenizer.convert_tokens_to_ids(tokens)

# 5. Implement Masked Language Modeling (MLM)
masked_lm_positions = []
masked_lm_labels = []
output_input_ids = list(input_ids)  # Create a mutable copy

for index, token_id in enumerate(input_ids):
    if token_id in tokenizer.all_special_ids:  # Don't mask special tokens
        continue

    if random.random() < masking_probability:
        masked_lm_positions.append(index)
        masked_lm_labels.append(token_id)

        # 80% of the time, replace with [MASK] token
        if random.random() < 0.8:
            output_input_ids[index] = tokenizer.mask_token_id
        # 10% of the time, replace with a random token (from vocab - excluding
        # special tokens for simplicity here)
        elif random.random() < 0.5:  # 0.1 probability in total (10% of 80% + 10% + 10%)
            random_token_id = random.choice(
                [
                    id
                    for id in range(len(vocab_list))
                    if id not in tokenizer.all_special_ids
                ]
            )
            output_input_ids[index] = random_token_id
        # 10% of the time, keep original token (no replacement - effectively
        # 10% of 15% = ~1.5% of tokens kept original when masked)
        else:
            pass  # Keep original token


# 6. Padding and Truncation
input_ids_padded = output_input_ids[:max_seq_length] + [tokenizer.pad_token_id] * (
    max_seq_length - min(len(output_input_ids), max_seq_length)
)
attention_mask = [1] * min(len(output_input_ids), max_seq_length) + [0] * (
    max_seq_length - min(len(output_input_ids), max_seq_length)
)
# All 0s for single document pre-training
token_type_ids = [0] * max_seq_length

# Masked LM positions and labels also need padding
masked_lm_positions_padded = masked_lm_positions[:max_predictions_per_seq] + [0] * (
    max_predictions_per_seq - min(len(masked_lm_positions), max_predictions_per_seq)
)  # Pad with 0 - positions are indices, so 0 is usually safe padding
masked_lm_ids_padded = masked_lm_labels[:max_predictions_per_seq] + [0] * (
    max_predictions_per_seq - min(len(masked_lm_labels), max_predictions_per_seq)
)  # Pad with 0 - or pad_token_id if you prefer
masked_lm_weights = [1.0] * min(len(masked_lm_positions), max_predictions_per_seq) + [
    0.0
] * (
    max_predictions_per_seq - min(len(masked_lm_positions), max_predictions_per_seq)
)  # Weights for loss


# 7. Create tf.train.Example
example = tf.train.Example(
    features=tf.train.Features(
        feature={
            "input_ids": tf.train.Feature(
                int64_list=tf.train.Int64List(value=input_ids_padded)
            ),
            "attention_mask": tf.train.Feature(
                int64_list=tf.train.Int64List(value=attention_mask)
            ),
            "token_type_ids": tf.train.Feature(
                int64_list=tf.train.Int64List(value=token_type_ids)
            ),
            "masked_lm_positions": tf.train.Feature(
                int64_list=tf.train.Int64List(value=masked_lm_positions_padded)
            ),
            "masked_lm_ids": tf.train.Feature(
                int64_list=tf.train.Int64List(value=masked_lm_ids_padded)
            ),
            "masked_lm_weights": tf.train.Feature(
                float_list=tf.train.FloatList(value=masked_lm_weights)
            ),
        }
    )
)


# 8. Write to TFRecord file
with tf.io.TFRecordWriter(output_tfrecord_file) as writer:
    writer.write(example.SerializeToString())

print(f"TFRecord file '{output_tfrecord_file}' created.")
print("Example features (first 20 elements):")
print("input_ids:", input_ids_padded[:20])
print("attention_mask:", attention_mask[:20])
print("masked_lm_positions:", masked_lm_positions_padded[:20])
print("masked_lm_ids:", masked_lm_ids_padded[:20])
print("masked_lm_weights:", masked_lm_weights[:20])
