#!/usr/bin/env python3
"""One-shot stdio MCP image source. Only an immutable assigned packet is readable."""
import argparse
import base64
import hashlib
import io
import json
from pathlib import Path
import sys


def sha(data):
    return hashlib.sha256(data).hexdigest()


def inspect_packet(attempt):
    from PIL import Image
    config = json.loads((attempt / 'input.json').read_bytes())
    content, delivered = [], []
    for item in config['frames']:
        path = attempt / item['snapshot']
        data = path.read_bytes()
        if sha(data) != item['sha256']:
            raise ValueError('Assigned original changed')
        with Image.open(io.BytesIO(data)) as image:
            image.load()
            if list(image.size) != [item['width'], item['height']]:
                raise ValueError('Original dimensions differ from pinned metadata')
            mime = Image.MIME.get(image.format)
        if mime not in ('image/png', 'image/jpeg', 'image/webp'):
            raise ValueError('Unsupported original image format')
        content.append({'type': 'text', 'text': json.dumps({k: item[k] for k in
                        ('index', 'game', 'locale', 'order', 'direction', 'sha256', 'width', 'height')})})
        content.append({'type': 'image', 'mimeType': mime,
                        'data': base64.b64encode(data).decode('ascii'),
                        '_meta': {'codex/imageDetail': 'original'}})
        delivered.append({'index': item['index'], 'sha256': item['sha256']})
    # Exclusive receipt also prevents replay if the MCP server itself restarts.
    with (attempt / 'delivery.json').open('x') as stream:
        json.dump({'packetSha256': config['packetSha256'], 'images': delivered,
                   'detail': 'original', 'deliveryCount': 1}, stream)
    return {'content': content}


def serve(attempt, source=None, destination=None):
    source, destination = source or sys.stdin, destination or sys.stdout
    for line in source:
        request = json.loads(line)
        if 'id' not in request:
            continue
        try:
            method = request.get('method')
            if method == 'initialize':
                result = {'protocolVersion': request.get('params', {}).get('protocolVersion', '2024-11-05'),
                          'capabilities': {'tools': {}},
                          'serverInfo': {'name': 'assigned-screenshot-packet', 'version': '1'}}
            elif method == 'ping':
                result = {}
            elif method == 'tools/list':
                result = {'tools': [{'name': 'inspect_packet',
                          'description': 'Inspect the assigned original-resolution screenshots exactly once. No other files or images are available.',
                          'annotations': {'readOnlyHint': True, 'destructiveHint': False,
                                          'idempotentHint': False, 'openWorldHint': False},
                          'inputSchema': {'type': 'object', 'properties': {}, 'additionalProperties': False}}]}
            elif method == 'tools/call':
                params = request.get('params', {})
                if params.get('name') != 'inspect_packet' or params.get('arguments', {}) != {}:
                    raise ValueError('Only the assigned empty-argument inspect_packet call is allowed')
                result = inspect_packet(attempt)
            else:
                raise ValueError('Unsupported packet method')
            response = {'jsonrpc': '2.0', 'id': request['id'], 'result': result}
        except (ValueError, OSError, KeyError) as error:
            response = {'jsonrpc': '2.0', 'id': request['id'],
                        'error': {'code': -32602, 'message': str(error)}}
        destination.write(json.dumps(response, separators=(',', ':')) + '\n')
        destination.flush()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('attempt', type=Path)
    serve(parser.parse_args().attempt.resolve())
