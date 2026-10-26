"""Update the bounded Unity Addressables local-bundle CRC without weakening checks."""
import base64
import hashlib
import json
import re
import struct
import zlib

import UnityPy


def bundle_crc(path):
    env = UnityPy.load(str(path))
    bundle = next(iter(env.files.values()))
    crc = 0
    for file in bundle.files.values():
        data = file.reader.bytes if hasattr(file, 'reader') else file.bytes
        crc = zlib.crc32(data, crc)
    return crc


def update_catalog(source_catalog, target_catalog, original_bundle, rebuilt_bundle):
    catalog = json.loads(source_catalog.read_text())
    data = bytearray(base64.b64decode(catalog['m_ExtraDataString']))
    old_crc = bundle_crc(original_bundle)
    new_crc = bundle_crc(rebuilt_bundle)
    cursor = 0
    changed = []
    while cursor < len(data):
        start = cursor
        assert data[cursor] == 7, 'Unknown Addressables extra-data type'
        cursor += 1
        count = data[cursor]; cursor += 1
        assembly = bytes(data[cursor:cursor+count]).decode('ascii'); cursor += count
        count = data[cursor]; cursor += 1
        kind = bytes(data[cursor:cursor+count]).decode('ascii'); cursor += count
        size = struct.unpack_from('<I', data, cursor)[0]; cursor += 4
        assert kind == 'UnityEngine.ResourceManagement.ResourceProviders.AssetBundleRequestOptions'
        assert assembly.startswith('Unity.ResourceManager,') and size % 2 == 0
        text = bytes(data[cursor:cursor+size]).decode('utf-16le')
        options = json.loads(text)
        if options['m_Hash'] == '298c5a4d1d1846b1a8d2c7d5da3f319c':
            assert options['m_Crc'] == old_crc, 'Original CRC positive control failed'
            assert options['m_UseCrcForCachedBundles'] is True
            assert options['m_UseUWRForLocalBundles'] is False
            before = options.copy()
            for key, value in [('m_Crc', new_crc), ('m_BundleSize', rebuilt_bundle.stat().st_size)]:
                pattern = r'("' + re.escape(key) + r'"\s*:\s*)(\d+)'
                matches = list(re.finditer(pattern, text))
                assert len(matches) == 1
                match = matches[0]
                assert int(match.group(2)) == before[key]
                digits = str(value)
                assert len(digits) <= len(match.group(2)), 'Catalog numeric field exceeds bounded capacity'
                text = text[:match.start(2)] + digits.rjust(len(match.group(2))) + text[match.end(2):]
                options[key] = value
            assert json.loads(text) == options
            encoded = text.encode('utf-16le')
            assert len(encoded) == size
            data[cursor:cursor+size] = encoded
            changed.append({'recordOffset': start, 'before': before, 'after': options})
        cursor += size
    assert cursor == len(data) and len(changed) == 1
    catalog['m_ExtraDataString'] = base64.b64encode(data).decode('ascii')
    target_catalog.write_text(json.dumps(catalog, separators=(',', ':')))
    reopened = json.loads(target_catalog.read_text())
    original = json.loads(source_catalog.read_text())
    assert set(reopened) == set(original)
    for key in original:
        if key != 'm_ExtraDataString':
            assert reopened[key] == original[key], key
    return {'sourceCrc32': f'{old_crc:08x}', 'rebuiltCrc32': f'{new_crc:08x}',
            'crcChecksPreserved': True, 'extraDataOffsetsPreserved': True,
            'catalogSha256': hashlib.sha256(target_catalog.read_bytes()).hexdigest(),
            'changes': changed}
