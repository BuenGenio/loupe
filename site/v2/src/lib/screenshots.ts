// Screenshots rendered from the app's demo data (tool/screenshots.sh) and
// described in src/data/screenshots.json. Each has a light file and, usually,
// a dark twin rendered from the same state; pages show the one that matches
// the site's theme. Missing files are skipped, so pages build before a render.
import type { ImageMetadata } from 'astro';

export interface Shot {
  slug: string;
  file: string;
  fileDark?: string;
  title: string;
  caption: string;
  alt: string;
  theme: 'light' | 'dark';
  device: 'phone' | 'tablet';
  featured: boolean;
  feature: string;
  image: ImageMetadata;
  dark?: ImageMetadata;
}

const images = import.meta.glob<{ default: ImageMetadata }>('../assets/screenshots/*.png', { eager: true });
const manifest = import.meta.glob<{ default: Omit<Shot, 'image' | 'dark'>[] }>('../data/screenshots.json', { eager: true });
const img = (file?: string) => (file ? images[`../assets/screenshots/${file}`]?.default : undefined);

export const screenshots: Shot[] = [];
for (const s of Object.values(manifest)[0]?.default ?? []) {
  const image = img(s.file);
  if (image) screenshots.push({ ...s, image, dark: img(s.fileDark) });
}

export const shot = (...slugs: string[]): Shot | undefined =>
  slugs.map((slug) => screenshots.find((s) => s.slug === slug)).find(Boolean);

export const shotFor = (feature: string): Shot | undefined => screenshots.find((s) => s.feature === feature && s.slug !== 'search-hero');
