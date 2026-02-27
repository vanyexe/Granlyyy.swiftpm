import re
import os

emoji_pattern = re.compile(
    r"("
    r"[\U0001F600-\U0001F64F]" # Emoticons
    r"|[\U0001F300-\U0001F5FF]" # Misc Symbols and Pictographs
    r"|[\U0001F680-\U0001F6FF]" # Transport and Map
    r"|[\U0001F1E6-\U0001F1FF]" # Regional indicator symbol
    r"|[\U0002600-\U00026FF]" # Misc symbols
    r"|[\U0002700-\U00027BF]" # Dingbats
    r"|[\U0001F900-\U0001F9FF]" # Supplemental Symbols and Pictographs
    r"|[\U0001fA00-\U0001fA6F]" # Symbols and Pictographs Extended-A
    r")", re.UNICODE)

for root, _, files in os.walk('.'):
    for f in files:
        if f.endswith('.swift'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as file:
                content = file.read()
                matches = set(emoji_pattern.findall(content))
                if matches:
                    print(f"{path}: {matches}")
