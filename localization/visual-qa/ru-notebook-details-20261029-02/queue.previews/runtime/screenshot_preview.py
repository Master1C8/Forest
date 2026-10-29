#!/usr/bin/env python3
"""Prepare bounded screenshot copies for model input, preserving source files."""
import argparse
import hashlib
import io
import json
from pathlib import Path

MAX_EDGE = 1280
QUALITY = 80
POLICY = 'screenshot-webp-1280-q80-v1'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def encode(data, crop=None):
    from PIL import Image, ImageOps
    with Image.open(io.BytesIO(data)) as original:
        if getattr(original, 'n_frames', 1) != 1:
            raise ValueError('A screenshot must contain exactly one frame.')
        original.load()
        source_dimensions = list(original.size)
        image = ImageOps.exif_transpose(original)
        if crop is not None:
            x, y, width, height = crop
            if (any(type(value) is not int for value in crop) or min(x, y) < 0 or
                    min(width, height) <= 0 or x + width > image.width or y + height > image.height):
                raise ValueError('Crop must be inside the source, in oriented source pixels.')
            image = image.crop((x, y, x + width, y + height))
        image = image.convert('RGBA' if 'A' in image.getbands() or 'transparency' in image.info else 'RGB')
        image.thumbnail((MAX_EDGE, MAX_EDGE), Image.Resampling.LANCZOS)
        output = io.BytesIO()
        image.save(output, format='WEBP', quality=QUALITY, method=6, exact=True,
                   icc_profile=image.info.get('icc_profile', b''))
        payload = output.getvalue()
        return payload, dict(policy=POLICY, sourceSha256=digest(data), sourceDimensions=source_dimensions,
                             sourceBytes=len(data), crop=list(crop) if crop is not None else None,
                             sha256=digest(payload), width=image.width, height=image.height,
                             bytes=len(payload), encodedBytesEstimate=4*((len(payload)+2)//3)+128,
                             format='WEBP', quality=QUALITY, maxEdge=MAX_EDGE)


def prepare(source, destination, crop=None):
    source, destination = source.resolve(), destination.absolute()
    if destination.resolve() == source or destination.is_symlink() or destination.exists():
        raise ValueError('Preview needs a new separate destination; never replace an original or existing copy.')
    before = source.read_bytes()
    payload, receipt = encode(before, crop)
    if source.read_bytes() != before:
        raise ValueError('Source changed during preview preparation.')
    destination.parent.mkdir(parents=True, exist_ok=True)
    with destination.open('xb') as stream:
        stream.write(payload)
    return {**receipt, 'source': str(source), 'path': str(destination.resolve())}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--crop', type=int, nargs=4, metavar=('X', 'Y', 'WIDTH', 'HEIGHT'))
    args = parser.parse_args()
    print(json.dumps(prepare(args.source, args.output, args.crop)))


if __name__ == '__main__':
    try:
        main()
    except (ValueError, OSError) as error:
        raise SystemExit(str(error))
