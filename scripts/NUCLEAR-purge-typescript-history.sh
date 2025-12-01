#!/bin/bash
# NUCLEAR OPTION: Purge ALL TypeScript from git history
# WARNING: This REWRITES HISTORY - irreversible!

set -e

echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║  ⚠️  NUCLEAR OPTION: PURGE TYPESCRIPT FROM GIT HISTORY  ⚠️        ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "🔥 This will REWRITE your entire git history!"
echo "🔥 This is IRREVERSIBLE - all TypeScript files will be erased!"
echo "🔥 Collaborators will need to re-clone the repo!"
echo ""
echo "Files to be purged from ENTIRE history:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git log --all --pretty=format: --name-only | grep -E "\.(ts|tsx)$" | sort -u | sed 's/^/  ❌ /'
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
read -p "Type 'PURGE' (all caps) to proceed: " confirm

if [ "$confirm" != "PURGE" ]; then
    echo "❌ Aborted. No changes made."
    exit 1
fi

# Check for git-filter-repo
if ! command -v git-filter-repo &> /dev/null; then
    echo "📦 Installing git-filter-repo..."
    if command -v pip3 &> /dev/null; then
        pip3 install git-filter-repo
    elif command -v pip &> /dev/null; then
        pip install git-filter-repo
    else
        echo "❌ ERROR: pip not found. Install git-filter-repo manually:"
        echo "   https://github.com/newren/git-filter-repo"
        exit 1
    fi
fi

# Create safety backup
echo "💾 Creating backup branch..."
git branch backup-before-typescript-purge-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true

# Show what will be kept
echo ""
echo "✅ Files that will be KEPT:"
git ls-tree -r HEAD --name-only | grep -E "\.(res|js|ecx|md|json|yml|sh)$" | head -20
echo "   ... and more"
echo ""

# Final confirmation
read -p "Last chance! Type 'YES' to continue: " final
if [ "$final" != "YES" ]; then
    echo "❌ Aborted. No changes made."
    exit 1
fi

echo ""
echo "🔥 PURGING TypeScript from git history..."
echo ""

# Remove ALL .ts and .tsx files from history
git filter-repo --path-glob '*.ts' --path-glob '*.tsx' --invert-paths --force

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ TypeScript PURGED from git history!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 New git history size:"
git count-objects -vH
echo ""
echo "🔍 Verify zero TypeScript:"
git log --all --pretty=format: --name-only | grep -E "\.(ts|tsx)$" || echo "  ✅ NO TYPESCRIPT FILES FOUND!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 NEXT STEPS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Force push to GitHub:"
echo "   git push --force-with-lease origin $(git branch --show-current)"
echo ""
echo "2. All collaborators MUST re-clone:"
echo "   rm -rf eclexia-playground"
echo "   git clone <url>"
echo ""
echo "3. GitHub linguist will re-analyze automatically"
echo "   (Takes 5-30 minutes after force push)"
echo ""
echo "💾 Backup created: $(git branch | grep backup-before)"
echo ""
echo "⚠️  DO NOT push until you've verified the changes!"
echo "   Run: git log --oneline"
echo "   Check that history looks correct."
echo ""
