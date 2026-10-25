#!/usr/bin/env python3
"""Create a text-only inspection gallery from the manually reviewed selection."""
import collections
import hashlib
import html
import json
import re
import shutil
import zipfile
from pathlib import Path
from PIL import Image, ImageDraw
from extract_assets import dump, sha

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'assets/source-v2'
OUT = ROOT / 'review'


def main():
    review = json.loads((ROOT / 'texture-review.json').read_text())
    textures = json.loads((SOURCE / 'textures.json').read_text())
    exported = [r for r in textures if r['status'] == 'exported']
    selected = {}
    groups = []
    for title, indices in review['groups'].items():
        members = []
        for index in indices:
            assert index not in selected, f'Duplicate selection {index}'
            row = dict(exported[index], reviewIndex=index, category=title)
            with Image.open(SOURCE / row['path']) as image:
                pixel_hash = hashlib.sha256(str(image.size).encode() + image.convert('RGBA').tobytes()).hexdigest()
            row['pixelSha256'] = pixel_hash
            selected[index] = row
            members.append(row)
        groups.append((title, members))
    OUT.mkdir(exist_ok=True)
    (OUT / 'sheets').mkdir(exist_ok=True)
    grouped = collections.defaultdict(list)
    for row in selected.values():
        grouped[(row['category'], row['pixelSha256'])].append(row)
    unique = [dict(rows[0], occurrences=[{k:r[k] for k in ['id','path','reviewIndex']} for r in rows])
              for rows in grouped.values()]
    font_images = [r for r in unique if r['category'] == 'Font atlases']
    dump(OUT / 'font-atlases.json', font_images)
    unique = [r for r in unique if r['category'] != 'Font atlases']
    (OUT / 'textures').mkdir(exist_ok=True)
    for row in unique:
        safe = re.sub(r'[^A-Za-z0-9_.-]+', '_', row['name']).strip('_')[:100]
        row['galleryPath'] = f'textures/{row["reviewIndex"]:04d}-{safe}.png'
        shutil.copyfile(SOURCE / row['path'], OUT / row['galleryPath'])
        assert sha(OUT / row['galleryPath']) == row['sha256']
    groups = [(title, rows) for title, rows in groups if title != 'Font atlases']
    selected_count = sum(len(r['occurrences']) for r in unique)
    dump(OUT / 'text-bearing-textures.json', {'sourceTexturesSha256': sha(SOURCE / 'textures.json'),
          'selectionSha256': sha(ROOT / 'texture-review.json'), 'screened': len(exported),
          'selectedOccurrences': selected_count, 'uniqueImages': len(unique), 'textures': unique})
    sections = []
    sheets = []
    for group_number, (title, _) in enumerate(groups):
        rows = [r for r in unique if r['category'] == title]
        cards = []
        for r in rows:
            url = r['galleryPath']
            cards.append(f'<article><a href="{html.escape(url)}"><img loading="lazy" src="{html.escape(url)}"></a>'
                         f'<h3>{html.escape(r["name"])}</h3><p>{r["width"]} × {r["height"]}; {len(r["occurrences"])} source occurrence(s)</p>'
                         + ''.join('<code>' + html.escape(x['id']) + '</code>' for x in r['occurrences']) + '</article>')
        sections.append(f'<section id="g{group_number}"><h2>{html.escape(title)} ({len(rows)})</h2><div class="grid">' + ''.join(cards) + '</div></section>')
        cols, per_page, cell_w, cell_h = (2, 6, 660, 410) if title == 'Tutorials' else (3, 18, 480, 195)
        for start in range(0, len(rows), per_page):
            page = rows[start:start+per_page]
            sheet = Image.new('RGB', (cols*cell_w, ((len(page)+cols-1)//cols)*cell_h+55), '#34343c')
            draw = ImageDraw.Draw(sheet)
            draw.text((16,14), f'{title} - original text-bearing textures', fill='white', font_size=22)
            for i,r in enumerate(page):
                x,y = (i%cols)*cell_w,(i//cols)*cell_h+55
                with Image.open(SOURCE/r['path']) as image:
                    im=image.convert('RGBA')
                    factor=min((cell_w-20)/im.width,(cell_h-55)/im.height,4)
                    im=im.resize((max(1,round(im.width*factor)),max(1,round(im.height*factor))),Image.Resampling.NEAREST)
                    sheet.paste(im,(x+(cell_w-im.width)//2,y+(cell_h-55-im.height)//2),im)
                draw.text((x+8,y+cell_h-49),f'#{r["reviewIndex"]} '+r['name'][:49],fill='white',font_size=14)
                draw.text((x+8,y+cell_h-28),f'{r["width"]}x{r["height"]} | {len(r["occurrences"])} source occurrence(s)',fill='#c4c4cc',font_size=12)
            name=f'{group_number+1:02d}-{start//per_page+1:02d}.jpg'
            sheet.save(OUT/'sheets'/name,quality=92)
            sheets.append({'category':title,'path':'sheets/'+name,'indices':[r['reviewIndex'] for r in page]})
    nav=' '.join(f'<a href="#g{i}">{html.escape(t)}</a>' for i,(t,_) in enumerate(groups))
    document='''<!doctype html><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>The Forest of Love — text-bearing textures</title><style>body{margin:32px;background:#202127;color:#eee;font:16px system-ui}h1{font-size:30px}nav{display:flex;flex-wrap:wrap;gap:18px}a{color:#9bcdff}.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(340px,1fr));gap:22px}article{background:#34343c;padding:16px;overflow:hidden;border-radius:12px}article img{width:100%;height:260px;object-fit:contain;image-rendering:pixelated}h3{font-size:17px;overflow-wrap:anywhere}code{display:block;font-size:11px;overflow-wrap:anywhere;margin-bottom:8px;color:#bbb}section{margin-top:42px}p{color:#bbb}</style>'''
    document+=f'<h1>The Forest of Love 0.45 — text-bearing textures</h1><p>{len(unique)} distinct previews, {selected_count} source texture occurrences. Click a texture for its original PNG. No localized artwork has been generated.</p><nav>{nav}</nav>'+''.join(sections)
    (OUT/'index.html').write_text(document)
    dump(OUT/'sheets.json',sheets)
    (ROOT/'dist').mkdir(exist_ok=True)
    archive = ROOT/'dist/text-bearing-textures.zip'
    paths = [OUT/'index.html',OUT/'text-bearing-textures.json',OUT/'sheets.json']
    paths += [OUT/row['galleryPath'] for row in unique]
    paths += [OUT/sheet['path'] for sheet in sheets]
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED) as z:
        for path in sorted(paths):
            z.write(path,path.relative_to(OUT).as_posix())
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None
        for path in paths:
            assert z.read(path.relative_to(OUT).as_posix()) == path.read_bytes()
    dump(OUT/'archive.json',{'path':'dist/text-bearing-textures.zip','sha256':sha(archive),
                            'uniquePNGCount':len(unique),'readBackEquality':'passed'})
    print(json.dumps({'selectedOccurrences':selected_count,'uniquePreviews':len(unique),'sheets':len(sheets)}))


if __name__=='__main__':
    main()
