import re
import os

for root, _, files in os.walk('.'):
    for f in files:
        if f.endswith('.swift'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as file:
                content = file.read()
                # Find characters outside basic Latin/ASCII, excluding simple punctuation/quotes/symbols
                # Basic Latin is U+0000 to U+007F
                # Let's find any char ordinal > 255
                high_chars = set(c for c in content if ord(c) > 255)
                # exclude common quotes/dashes:
                high_chars -= set("’“”«»—–…©®™•·°")
                # exclude Chinese/Japanese/Hindi/etc depending on localization
                # but if there are emojis they will show up here
                emojis_potential = set(c for c in high_chars if not (0x0900 <= ord(c) <= 0x097F or 0x4E00 <= ord(c) <= 0x9FFF or 0x0400 <= ord(c) <= 0x04FF or ord(c) in (0x00E1, 0x00E9, 0x00ED, 0x00F3, 0x00FA, 0x00F1, 0x00FC, 0x00E4, 0x00F6, 0x00A1, 0x00BF)))
                
                if emojis_potential:
                    print(f"{path}: {''.join(emojis_potential)}")
