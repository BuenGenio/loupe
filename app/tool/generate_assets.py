"""Generates the demo mailbox images and the launcher icon sources for Loupe.

Run from anywhere: `python3 app/tool/generate_assets.py` (needs Pillow), then
`dart run flutter_launcher_icons` in app/.
"""
import math, os, random
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, 'assets/demo')
ICON = os.path.join(ROOT, 'assets/icon')
os.makedirs(OUT, exist_ok=True)
os.makedirs(ICON, exist_ok=True)
rnd = random.Random(7)

def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(len(a)))

def vgrad(img, box, top, bottom):
    d = ImageDraw.Draw(img)
    x0, y0, x1, y1 = box
    for y in range(y0, y1):
        t = (y - y0) / max(1, (y1 - y0 - 1))
        d.line([(x0, y), (x1, y)], fill=lerp(top, bottom, t))

def ridge(w, base, amp, seed, rough=6):
    r = random.Random(seed)
    pts = []
    phase = [r.random() * 6 for _ in range(rough)]
    for x in range(0, w + 8, 8):
        y = base
        for i in range(rough):
            y += math.sin(x / (w / (i + 1.3)) * 2 + phase[i]) * amp / (i + 1)
        pts.append((x, y))
    return pts

def mountains(w=960, h=640):
    img = Image.new('RGB', (w, h))
    vgrad(img, (0, 0, w, h), (255, 183, 120), (120, 90, 160))
    d = ImageDraw.Draw(img)
    d.ellipse((w * 0.62, h * 0.28, w * 0.62 + 110, h * 0.28 + 110), fill=(255, 230, 170))
    for i, (col, base, amp) in enumerate([((150, 110, 160), 0.55, 70), ((110, 80, 130), 0.66, 60), ((70, 55, 95), 0.78, 50), ((40, 35, 60), 0.9, 30)]):
        pts = ridge(w, h * base, amp, 10 + i)
        d.polygon(pts + [(w, h), (0, h)], fill=col)
    return img.filter(ImageFilter.GaussianBlur(0.6))

def sea(w=960, h=640):
    img = Image.new('RGB', (w, h))
    vgrad(img, (0, 0, w, int(h * 0.55)), (120, 190, 240), (205, 232, 250))
    vgrad(img, (0, int(h * 0.55), w, h), (40, 120, 170), (10, 60, 100))
    d = ImageDraw.Draw(img)
    for i in range(60):
        y = rnd.randint(int(h * 0.57), h)
        x = rnd.randint(0, w)
        d.line([(x, y), (x + rnd.randint(20, 80), y)], fill=(170, 215, 240), width=2)
    # a sailboat
    d.polygon([(420, 330), (420, 250), (470, 330)], fill=(250, 250, 250))
    d.polygon([(400, 335), (480, 335), (465, 350), (410, 350)], fill=(150, 60, 50))
    # clouds
    for cx, cy in [(180, 110), (640, 80), (820, 150)]:
        for k in range(5):
            r = rnd.randint(28, 46)
            ox = cx + rnd.randint(-50, 50)
            oy = cy + rnd.randint(-12, 12)
            d.ellipse((ox - r, oy - r, ox + r, oy + r), fill=(255, 255, 255))
    return img.filter(ImageFilter.GaussianBlur(0.8))

def city(w=960, h=640):
    img = Image.new('RGB', (w, h))
    vgrad(img, (0, 0, w, h), (24, 34, 74), (232, 120, 90))
    d = ImageDraw.Draw(img)
    x = 0
    while x < w:
        bw = rnd.randint(40, 100)
        bh = rnd.randint(120, 380)
        col = lerp((30, 30, 55), (60, 50, 80), rnd.random())
        d.rectangle((x, h - bh, x + bw, h), fill=col)
        for wy in range(h - bh + 12, h - 10, 18):
            for wx in range(x + 8, x + bw - 8, 14):
                if rnd.random() < 0.35:
                    d.rectangle((wx, wy, wx + 6, wy + 9), fill=(255, 214, 120))
        x += bw + rnd.randint(2, 10)
    return img

def forest(w=960, h=640):
    img = Image.new('RGB', (w, h))
    vgrad(img, (0, 0, w, h), (200, 230, 210), (60, 110, 80))
    d = ImageDraw.Draw(img)
    for layer, col in enumerate([(120, 160, 130), (80, 130, 95), (45, 95, 65), (25, 65, 45)]):
        for i in range(26):
            cx = rnd.randint(-20, w + 20)
            base = h * (0.55 + layer * 0.12) + rnd.randint(-10, 10)
            th = rnd.randint(120, 220) * (0.7 + layer * 0.15)
            tw = th * 0.38
            d.polygon([(cx, base - th), (cx - tw, base), (cx + tw, base)], fill=col)
    return img.filter(ImageFilter.GaussianBlur(0.5))

for name, fn in [('photo_beach.jpg', sea), ('photo_mountains.jpg', mountains), ('photo_city.jpg', city), ('photo_forest.jpg', forest)]:
    fn().save(os.path.join(OUT, name), quality=78, optimize=True)

def font(size, bold=False):
    for p in ['/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf' if bold else '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
              '/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf' if bold else '/usr/share/fonts/dejavu/DejaVuSans.ttf']:
        if os.path.exists(p):
            return ImageFont.truetype(p, size)
    return ImageFont.load_default()

# Newsletter: logo, hero and two product shots.
logo = Image.new('RGB', (360, 80), (255, 255, 255))
d = ImageDraw.Draw(logo)
d.polygon([(10, 70), (40, 15), (70, 70)], fill=(34, 102, 68))
d.polygon([(40, 70), (62, 32), (84, 70)], fill=(70, 140, 100))
d.text((98, 22), 'TRAILHEAD', font=font(30, True), fill=(34, 60, 50))
logo.save(os.path.join(OUT, 'trailhead_logo.png'), optimize=True)

hero = mountains(1200, 520).crop((0, 0, 1200, 520))
dh = ImageDraw.Draw(hero)
dh.text((60, 360), 'Into the cold.', font=font(64, True), fill=(255, 255, 255))
dh.text((64, 440), 'The autumn layering guide', font=font(30), fill=(255, 240, 225))
hero.resize((600, 260)).save(os.path.join(OUT, 'trailhead_hero.jpg'), quality=80, optimize=True)

def product(color, shape):
    im = Image.new('RGB', (280, 280), (243, 241, 236))
    dd = ImageDraw.Draw(im)
    if shape == 'jacket':
        dd.polygon([(90, 60), (190, 60), (230, 110), (210, 120), (200, 230), (80, 230), (70, 120), (50, 110)], fill=color)
        dd.line([(140, 64), (140, 228)], fill=(30, 30, 30), width=3)
    else:
        dd.rounded_rectangle((70, 50, 210, 240), 40, fill=color)
        dd.rounded_rectangle((95, 90, 185, 150), 14, fill=lerp(color, (255, 255, 255), 0.25))
        dd.line([(90, 50), (110, 20), (170, 20), (190, 50)], fill=(60, 60, 60), width=6)
    return im

product((200, 80, 40), 'jacket').save(os.path.join(OUT, 'product_jacket.jpg'), quality=82, optimize=True)
product((40, 90, 130), 'pack').save(os.path.join(OUT, 'product_pack.jpg'), quality=82, optimize=True)

shop = Image.new('RGB', (240, 64), (255, 255, 255))
d = ImageDraw.Draw(shop)
d.rounded_rectangle((4, 8, 52, 56), 10, fill=(139, 69, 19))
d.text((16, 16), 'CB', font=font(22, True), fill=(255, 255, 255))
d.text((62, 18), 'Corner Bookshop', font=font(20, True), fill=(60, 40, 20))
shop.save(os.path.join(OUT, 'bookshop_logo.png'), optimize=True)

# Launcher icon: the logo shared with Expression Search Reloaded
# (docs/branding/loupe-logo.png, transparent background) on a navy gradient.
LOGO_PATH = os.path.join(os.path.dirname(ROOT), 'docs/branding/loupe-logo.png')
NAVY_TOP, NAVY_BOTTOM = (12, 34, 56), (19, 75, 110)


def navy(size):
    g = Image.new('RGBA', (size, size))
    d = ImageDraw.Draw(g)
    for y in range(size):
        d.line([(0, y), (size, y)], fill=lerp(NAVY_TOP, NAVY_BOTTOM, y / (size - 1)) + (255,))
    return g


def logo_layer(size, scale, shadow=True):
    """The logo, cropped to its content and centred at [scale] of [size]."""
    logo = Image.open(LOGO_PATH).convert('RGBA')
    logo = logo.crop(logo.getbbox())
    k = size * scale / max(logo.size)
    logo = logo.resize((round(logo.width * k), round(logo.height * k)), Image.LANCZOS)
    out = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    x, y = (size - logo.width) // 2, (size - logo.height) // 2
    if shadow:
        alpha = logo.split()[3].point(lambda v: int(v * 0.35))
        sh = Image.new('RGBA', (size, size), (0, 0, 0, 0))
        sh.paste((4, 14, 26, 255), (x, y + round(size * 0.02)), alpha)
        out = Image.alpha_composite(out, sh.filter(ImageFilter.GaussianBlur(size * 0.02)))
    out.alpha_composite(logo, (x, y))
    return out


def monochrome(size, scale):
    """Android 13 themed icon: only the loupe's ring and handle (the darker
    teal parts); the white envelope and the pale lens drop out."""
    glyph = logo_layer(size, scale, shadow=False)
    px = glyph.load()
    for yy in range(size):
        for xx in range(size):
            r, g, b, a = px[xx, yy]
            if a:
                light = (max(r, g, b) + min(r, g, b)) / 510
                keep = min(1.0, max(0.0, (0.80 - light) / 0.45))
                px[xx, yy] = (255, 255, 255, int(a * keep))
    return glyph


# Legacy and iOS icon: full bleed, no alpha. Visible logo ≈ 62% of the icon.
icon = navy(1024)
icon.alpha_composite(logo_layer(1024, 0.62))
icon.convert('RGB').save(os.path.join(ICON, 'icon.png'))
# Adaptive icon: flutter_launcher_icons insets the foreground by 16% per side
# (to 68%), and masks show the middle 72/108 of the canvas, so 0.61 here gives
# the same visible size as above and keeps the handle inside a circle mask.
navy(1024).convert('RGB').save(os.path.join(ICON, 'icon_background.png'))
logo_layer(1024, 0.61).save(os.path.join(ICON, 'icon_foreground.png'))
monochrome(1024, 0.61).save(os.path.join(ICON, 'icon_monochrome.png'))
# In-app (welcome screen, About): rounded square.
small = icon.resize((240, 240), Image.LANCZOS)
mask = Image.new('L', (960, 960), 0)
ImageDraw.Draw(mask).rounded_rectangle((0, 0, 959, 959), 216, fill=255)
small.putalpha(mask.resize((240, 240), Image.LANCZOS))
small.save(os.path.join(ICON, 'icon_rounded.png'), optimize=True)
print('ok')
