import os
import re

directory = "/Users/adityashastri/Desktop/Granlyyy.swiftpm"

# Mapping rules
replacements = [
    # Explicit custom Baskervilles
    (r'\.font\(\.custom\("Baskerville-Bold", size: \d+\)\)', '.font(.granlyTitle2)'),
    (r'\.font\(\.custom\("Baskerville", size: \d+\)\)', '.font(.granlyHeadline)'),
    
    # System design serif replacements
    (r'\.font\(\.system\(size: [2-9]\d+, weight: \.bold, design: \.serif\)\)', '.font(.granlyTitle)'),
    (r'\.font\(\.system\(size: \d+, weight: \.bold, design: \.serif\)\)', '.font(.granlyHeadline)'),
    (r'\.font\(\.system\(size: \d+, weight: \.semibold, design: \.serif\)\)', '.font(.granlyHeadline)'),
    (r'\.font\(\.system\(size: \d+, design: \.serif\)\)', '.font(.granlyBody)'),
    
    # Generic titles to granlyTitle variants
    (r'\.font\(\.largeTitle(\.bold\(\))?\)', '.font(.granlyTitle)'),
    (r'\.font\(\.title(\.bold\(\))?\)', '.font(.granlyTitle)'),
    (r'\.font\(\.title2(\.bold\(\))?\)', '.font(.granlyTitle2)'),
    (r'\.font\(\.title3(\.bold\(\))?\)', '.font(.granlyHeadline)'),
    
    # Generic body / subheadline to granly variants
    (r'\.font\(\.headline(\.bold\(\))?\)', '.font(.granlyHeadline)'),
    (r'\.font\(\.subheadline(\.bold\(\))?\)', '.font(.granlySubheadline)'),
    (r'\.font\(\.body\)', '.font(.granlyBody)'),
    (r'\.font\(\.body\.weight\(\.medium\)\)', '.font(.granlyBody)'),
    (r'\.font\(\.callout\)', '.font(.granlyBody)'),
    (r'\.font\(\.caption(\.bold\(\))?\)', '.font(.granlyCaption)'),
    (r'\.font\(\.caption2(\.bold\(\))?\)', '.font(.granlyCaption)')
]

for root, _, files in os.walk(directory):
    for filename in files:
        if filename.endswith(".swift") and filename != "FontExtensions.swift" and filename != "OnboardingContentView.swift":
            filepath = os.path.join(root, filename)
            
            with open(filepath, 'r') as f:
                content = f.read()
            
            original_content = content
            for pattern, replacement in replacements:
                content = re.sub(pattern, replacement, content)
                
            if content != original_content:
                with open(filepath, 'w') as f:
                    f.write(content)
                print(f"Updated {filename}")
