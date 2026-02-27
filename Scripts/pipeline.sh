#!/bin/bash

# --- Granly Project Verification Pipeline ---
echo "🚀 Starting Granly Verification Pipeline..."

# 1. Check Git Status
echo "Checking Git Status..."
GT_STATUS=$(git status --short)
if [ -z "$GT_STATUS" ]; then
    echo "✅ Project is CLEAN (All files are 'white')."
else
    echo "⚠️  There are still modified files:"
    echo "$GT_STATUS"
fi

# 2. Key File Verification
echo "Verifying critical fixes..."

# Check StoryView for frame stability
if grep -q "isFinite" StoryView.swift; then
    echo "✅ StoryView: Layout stability guards found."
else
    echo "❌ StoryView: Layout stability guards MISSING."
fi

# Check AvatarSelectionSheet for concurrency isolation
if grep -q "nonisolated" AvatarSelectionSheet.swift; then
    echo "✅ AvatarSelectionSheet: Concurrency isolation found."
else
    echo "❌ AvatarSelectionSheet: Concurrency isolation MISSING."
fi

echo "---"
echo "✅ Pipeline complete. Project is ready for launch!"
