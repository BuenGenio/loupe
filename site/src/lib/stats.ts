// Facts about the codebase, counted at build time from the repo the site lives
// in, so the numbers on the site never go stale.
import { execSync } from 'node:child_process';
import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join, resolve } from 'node:path';

// The monorepo root (the build runs in site/; this module is bundled first).
const root = resolve(process.cwd(), '..');

function walk(dir: string, out: string[] = []): string[] {
  for (const name of readdirSync(dir)) {
    if (name.startsWith('.') || name === 'build' || name === 'node_modules') continue;
    const path = join(dir, name);
    if (statSync(path).isDirectory()) walk(path, out);
    else out.push(path);
  }
  return out;
}

function count(): { packages: number; tests: number; commits: number | null } {
  try {
    const packages = readdirSync(join(root, 'packages')).filter((p) => statSync(join(root, 'packages', p)).isDirectory());
    const testFiles = [join(root, 'app'), ...packages.map((p) => join(root, 'packages', p))]
      .flatMap((dir) => walk(dir))
      .filter((f) => f.endsWith('_test.dart'));
    const tests = testFiles.reduce((n, f) => n + (readFileSync(f, 'utf8').match(/\b(?:test|testWidgets)\(/g)?.length ?? 0), 0);
    let commits: number | null = null;
    try {
      commits = Number(execSync('git rev-list --count HEAD', { cwd: root, stdio: ['ignore', 'pipe', 'ignore'] }).toString().trim());
      if (commits < 50) commits = null; // a shallow CI clone: don't show a misleading number
    } catch {}
    return { packages: packages.length, tests, commits };
  } catch {
    return { packages: 11, tests: 0, commits: null };
  }
}

export const stats = count();

// 1984 -> "1,900+"; keeps the number honest while it keeps growing.
export const roughly = (n: number) => (n >= 1000 ? `${(Math.floor(n / 100) * 100).toLocaleString('en-US')}+` : `${n}`);
