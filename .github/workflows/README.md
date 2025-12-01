# GitHub Actions Workflows

## 🎯 FOSS-Only Pipeline

This project uses **100% Free and Open Source Software** for CI/CD - **NO external monitoring services required**.

### Replaced: Datadog Synthetics → Playwright

**Old (Removed):**
- `DataDog/synthetics-ci-github-action` - Required API keys & paid account
- External monitoring service dependency
- Vendor lock-in

**New (FOSS):**
- **Playwright** - FOSS browser automation for synthetic testing
- **Trivy** - FOSS security scanning
- **GitHub Actions** - Built-in CI/CD features only
- **NO API keys required**
- **NO external accounts needed**

## Active Workflows

### `ci.yml` - Main CI/CD Pipeline

Runs on:
- Push to `main` or `claude/**` branches
- Pull requests to `main`
- Manual workflow dispatch

**Jobs:**
1. **RSR Compliance Check** - Validates RSR Silver Level compliance
2. **Security.txt Validation** - RFC 9116 compliance
3. **ReScript Build** - Compiles `.res` → `.js`
4. **Example Tests** - Validates example programs
5. **Synthetic Testing** - Playwright-based functional tests (replaces Datadog)
6. **Code Quality** - Static analysis, LOC counting
7. **Security Scan** - Trivy vulnerability scanning
8. **Summary** - Aggregated results

## FOSS Tools Used

| Purpose | Tool | License | Notes |
|---------|------|---------|-------|
| CI/CD | GitHub Actions | N/A | Built-in platform feature |
| Browser Testing | Playwright | Apache 2.0 | Replaces Datadog Synthetics |
| Security Scanning | Trivy | Apache 2.0 | CVE/vulnerability detection |
| ReScript Compiler | ReScript | MIT | Functional language → JS |

## No External Services Required

✅ **No Datadog account**
✅ **No API keys**
✅ **No paid monitoring**
✅ **100% FOSS stack**

## Migration Notes

If you see errors about Datadog, delete any old workflow files:

```bash
# List all workflows
ls -la .github/workflows/

# Remove old Datadog workflows (if any exist)
git rm .github/workflows/*datadog*.yml
git rm .github/workflows/*synthetics*.yml

# Commit the change
git commit -m "refactor: Replace Datadog with FOSS Playwright testing"
git push
```

## Local Testing

To run the synthetic tests locally:

```bash
# Install Playwright
npm install -D playwright

# Run synthetic tests
node synthetic-test.mjs
```

## Questions?

See the main CI/CD pipeline: `.github/workflows/ci.yml`
