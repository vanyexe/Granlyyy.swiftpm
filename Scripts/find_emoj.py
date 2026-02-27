import os
import emoji

for root, _, files in os.walk('.'):
    for f in files:
        if f.endswith('.swift'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as file:
                content = file.read()
                found = [c for c in content if c in emoji.EMOJI_DATA]
                if found:
                    print(f"{path}: {set(found)}")
