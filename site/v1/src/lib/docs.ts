import { getCollection, type CollectionEntry } from 'astro:content';

export const sections = ['Get started', 'Using Loupe', 'Accounts & security', 'Reference'] as const;

export async function allDocs(): Promise<CollectionEntry<'docs'>[]> {
  return (await getCollection('docs')).sort((a, b) => a.data.order - b.data.order);
}

export async function docsBySection() {
  const docs = await allDocs();
  return sections
    .map((section) => ({ section, docs: docs.filter((d) => d.data.section === section) }))
    .filter((g) => g.docs.length > 0);
}

// Markdown to plain text, for search snippets and structured data.
export function plain(md: string): string {
  return md
    .replace(/```[\s\S]*?```/g, ' ')
    .replace(/`([^`]+)`/g, '$1')
    .replace(/!\[[^\]]*\]\([^)]*\)/g, '')
    .replace(/\[([^\]]+)\]\([^)]*\)/g, '$1')
    .replace(/^\s{0,3}>\s?/gm, '')
    .replace(/^#{1,6}\s+/gm, '')
    .replace(/^\s*[-*+]\s+/gm, '')
    .replace(/^\s*\d+\.\s+/gm, '')
    .replace(/\|/g, ' ')
    .replace(/[*_~]{1,3}([^*_~]+)[*_~]{1,3}/g, '$1')
    .replace(/<[^>]+>/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

// "### Question" headings followed by their answer, for FAQPage data.
export function faqItems(md: string): { question: string; answer: string }[] {
  const items: { question: string; answer: string }[] = [];
  const parts = md.split(/^###\s+/m).slice(1);
  for (const part of parts) {
    const [first, ...rest] = part.split('\n');
    const answer = plain(rest.join('\n').split(/^#{2,3}\s/m)[0]);
    if (first.trim() && answer) items.push({ question: first.trim(), answer });
  }
  return items;
}
