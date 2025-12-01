# Eclexia - Economics-as-Code DSL

**ReScript + Deno** (NO TypeScript, NO Node.js runtime!)

## Tech Stack

- **ReScript**: Compiles `.res` to `.js`  
- **Deno**: Runs the `.js` (NO Node.js!)
- **npm**: ONLY for ReScript compiler (or use standalone binary)

## Setup

```bash
# Install ReScript compiler (one-time)
npm install

# Compile ReScript → JS
npm run res:build

# Run on Deno
deno run --allow-read src/Main.js examples/test.ecx
```

## Key Point

✅ **Compilation**: ReScript (.res → .js)  
✅ **Runtime**: Pure Deno (compiled .js files)  
❌ **NO TypeScript**  
❌ **NO Node.js runtime**

The compiled `.js` files are checked into git so users can run on Deno without compiling!
