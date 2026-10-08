#!/usr/bin/env python3
"""Renders the social schedule (marketing/calendar.json plus the video drafts)
as one self-contained HTML page, for sharing as an artifact or opening locally.

    cd marketing/publisher && npm run calendar
    node bin/social.mjs calendar --dir ../posts/_drafts --out ../.state/drafts-calendar.json
    python3 ../creative/calendar_page.py <out.html>
"""
import base64, io, json, pathlib, sys
from PIL import Image

ROOT = pathlib.Path(__file__).resolve().parents[1]
cal = json.loads((ROOT / "calendar.json").read_text())
drafts_file = ROOT / ".state" / "drafts-calendar.json"
drafts = json.loads(drafts_file.read_text())["entries"] if drafts_file.exists() else []

thumbs = {}
def thumb(src):
    if src in thumbs:
        return thumbs[src]
    path = ROOT / src
    if not path.exists():
        thumbs[src] = None
        return None
    im = Image.open(path).convert("RGB")
    im.thumbnail((200, 250))
    buf = io.BytesIO()
    im.save(buf, "JPEG", quality=70)
    thumbs[src] = "data:image/jpeg;base64," + base64.b64encode(buf.getvalue()).decode()
    return thumbs[src]

posts = {}
for e in cal["entries"] + [dict(d, status="draft", needsVideo=True) for d in drafts]:
    p = posts.setdefault(e["id"], {
        "id": e["id"], "datetime": e["datetime"], "date": e["date"], "time": e["time"],
        "campaign": e["campaign"], "status": e["status"], "needsVideo": e.get("needsVideo", False),
        "source": e.get("source", ""), "media": [], "platforms": [],
    })
    if not p["media"]:
        p["media"] = [{"thumb": thumb(m["src"]), "alt": m.get("alt", ""), "kind": m.get("kind", "image")} for m in e.get("media", [])]
    p["platforms"].append({"platform": e["platform"], "label": e["platformLabel"], "mode": e["mode"], "title": e.get("title"), "text": e.get("text") or ""})

data = sorted(posts.values(), key=lambda p: p["datetime"])
out = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "calendar.html")
template = (pathlib.Path(__file__).parent / "calendar_page.html").read_text()
out.write_text(template.replace("/*DATA*/[]", json.dumps(data, ensure_ascii=False)).replace("{{GENERATED}}", cal["generatedAt"][:10]))
print(f"{len(data)} posts → {out}")
