import spacy
from spacy.training.example import Example
import pandas as pd

# Load base English model
nlp = spacy.load("en_core_web_sm")

# Add new entity labels if not present
if "ner" not in nlp.pipe_names:
    ner = nlp.add_pipe("ner")
else:
    ner = nlp.get_pipe("ner")

ner.add_label("ITEM")
ner.add_label("AMOUNT")

# Read CSV training data
df = pd.read_csv("training_data.csv")

# Prepare training data
TRAIN_DATA = []
for _, row in df.iterrows():
    text = row["sentence"]
    entities = []
    # Convert offsets to int (in case CSV stores as float)
    try:
        item_start = int(row["item_start"])
        item_end = int(row["item_end"])
        entities.append((item_start, item_end, "ITEM"))
    except:
        pass  # skip if no item offsets
    
    try:
        amount_start = int(row["amount_start"])
        amount_end = int(row["amount_end"])
        entities.append((amount_start, amount_end, "AMOUNT"))
    except:
        pass  # skip if no amount offsets

    TRAIN_DATA.append((text, {"entities": entities}))

print(f"Loaded {len(TRAIN_DATA)} training examples from CSV")

# Disable other pipeline components to speed up training
pipe_exceptions = ["ner"]
unaffected_pipes = [pipe for pipe in nlp.pipe_names if pipe not in pipe_exceptions]

with nlp.disable_pipes(*unaffected_pipes):
    optimizer = nlp.resume_training()
    for epoch in range(50):
        losses = {}
        for text, annotations in TRAIN_DATA:
            doc = nlp.make_doc(text)
            example = Example.from_dict(doc, annotations)
            nlp.update([example], drop=0.3, losses=losses)
        print(f"Epoch {epoch+1}, Losses: {losses}")

# Save the trained model
nlp.to_disk("farm_expense_model")
print("Model saved to farm_expense_model")
