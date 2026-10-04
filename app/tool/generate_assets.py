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

# Launcher icon: a loupe over a subtle envelope on a blue gradient. Shapes are
# drawn on separate supersampled layers and alpha-composited.
def layer(size, draw_fn, ss=4):
    big = Image.new('RGBA', (size * ss, size * ss), (0, 0, 0, 0))
    draw_fn(ImageDraw.Draw(big), size * ss)
    return big.resize((size, size), Image.LANCZOS)


def gradient(size):
    bg = Image.new('RGBA', (size, size))
    d = ImageDraw.Draw(bg)
    for y in range(size):
        d.line([(0, y), (size, y)], fill=lerp((90, 176, 255), (20, 84, 214), y / (size - 1)) + (255,))
    return bg


def icon(size, with_bg=True, inset=0.0):
    base = gradient(size) if with_bg else Image.new('RGBA', (size, size), (0, 0, 0, 0))

    def P(s, x, y):
        sc = s * (1 - inset)
        o = (s - sc) / 2
        return (o + x * sc, o + y * sc)

    def W(s, v):
        return max(1, int(v * s * (1 - inset)))

    def env(d, s):
        x0, y0, x1, y1 = 0.16, 0.27, 0.72, 0.63
        d.rounded_rectangle([P(s, x0, y0), P(s, x1, y1)], radius=W(s, 0.045), fill=(255, 255, 255, 46),
                            outline=(255, 255, 255, 120), width=W(s, 0.014))
        d.line([P(s, x0 + 0.025, y0 + 0.035), P(s, (x0 + x1) / 2, 0.47), P(s, x1 - 0.025, y0 + 0.035)],
               fill=(255, 255, 255, 120), width=W(s, 0.014), joint='curve')

    base = Image.alpha_composite(base, layer(size, env))
    cx, cy, r = 0.52, 0.47, 0.205
    ang = math.radians(45)

    def handle(dx, dy):
        return (cx + (r + 0.02) * math.cos(ang) + dx, cy + (r + 0.02) * math.sin(ang) + dy,
                cx + (r + 0.22) * math.cos(ang) + dx, cy + (r + 0.22) * math.sin(ang) + dy)

    def shadow(d, s):
        d.ellipse([P(s, cx - r + 0.015, cy - r + 0.025), P(s, cx + r + 0.015, cy + r + 0.025)],
                  outline=(0, 30, 90, 70), width=W(s, 0.055))
        x0, y0, x1, y1 = handle(0.015, 0.025)
        d.line([P(s, x0, y0), P(s, x1, y1)], fill=(0, 30, 90, 70), width=W(s, 0.075))

    base = Image.alpha_composite(base, layer(size, shadow).filter(ImageFilter.GaussianBlur(size * 0.012)))

    def lens(d, s):
        d.ellipse([P(s, cx - r, cy - r), P(s, cx + r, cy + r)], fill=(255, 255, 255, 40))
        x0, y0, x1, y1 = handle(0, 0)
        d.line([P(s, x0, y0), P(s, x1, y1)], fill=(255, 255, 255, 255), width=W(s, 0.075))
        hw = 0.075 / 2
        d.ellipse([P(s, x1 - hw, y1 - hw), P(s, x1 + hw, y1 + hw)], fill=(255, 255, 255, 255))
        d.ellipse([P(s, cx - r, cy - r), P(s, cx + r, cy + r)], outline=(255, 255, 255, 255), width=W(s, 0.052))
        g = r * 0.62
        d.arc([P(s, cx - g, cy - g), P(s, cx + g, cy + g)], 195, 255, fill=(255, 255, 255, 230), width=W(s, 0.028))

    return Image.alpha_composite(base, layer(size, lens))


icon(1024).convert('RGB').save(os.path.join(ICON, 'icon.png'))
gradient(1024).convert('RGB').save(os.path.join(ICON, 'icon_background.png'))
# Adaptive foreground: flutter_launcher_icons adds a 16% inset, so keep this one small.
icon(1024, with_bg=False, inset=0.10).save(os.path.join(ICON, 'icon_foreground.png'))
small = icon(240)
mask = Image.new('L', (960, 960), 0)
ImageDraw.Draw(mask).rounded_rectangle((0, 0, 959, 959), 216, fill=255)
small.putalpha(mask.resize((240, 240), Image.LANCZOS))
small.save(os.path.join(ICON, 'icon_rounded.png'), optimize=True)
print('ok')
