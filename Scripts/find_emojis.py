import os
import re

emoji_pattern = re.compile(
    "["
    "\U0001f600-\U0001f64f"  # emoticons
    "\U0001f300-\U0001f5ff"  # symbols & pictographs
    "\U0001f680-\U0001f6ff"  # transport & map symbols
    "\U0001f1e0-\U0001f1ff"  # flags (iOS)
    "\U0001f900-\U0001f9ff"  # supplemental symbols and pictographs
    "\U0002600-\U00026ff"
    "\U0002700-\U00027bf"
    "]+",
    re.UNICODE)

for root, dirs, files in os.walk('.'):
    for file in files:
        if file.endswith('.swift'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
                matches = emoji_pattern.finditer(content)
                for match in matches:
                    print(f"{path}: {match.group()}")

