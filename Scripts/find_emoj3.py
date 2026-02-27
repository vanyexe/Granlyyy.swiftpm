import os
import emoji

def extract_emojis(text):
    return [c for c in text if c in emoji.EMOJI_DATA]

for root, _, files in os.walk('.'):
    for f in files:
        if f.endswith('.swift'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as file:
                content = file.read()
                found = list(set(extract_emojis(content)))
                if found and any(c != '©' for c in found):
                    print(f"{path}: {''.join(found)}")
