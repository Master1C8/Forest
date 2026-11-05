"""Shared optional renderer normalization for offline installer producers."""
import hashlib
from pathlib import Path

PATH='Managed/Unity.TextMeshPro.dll'
ORIGINAL_SHA='775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483'
ORIGINAL_BYTES=370176

def pin(path):
    data=Path(path).read_bytes()
    return dict(bytes=len(data),sha256=hashlib.sha256(data).hexdigest())

def original(root):
    source=Path(root)/'localization/framework/forest045-shared-v2/references'/Path(PATH).name
    if pin(source)!=dict(bytes=ORIGINAL_BYTES,sha256=ORIGINAL_SHA):
        raise ValueError('Registered immutable original TMP renderer differs')
    return source

def localized(root,directory,files,requires_adapter,prefix=''):
    """Resolve bytes without writing an invented member into compiler outputs."""
    key=prefix+PATH
    if not requires_adapter:
        if key in files:raise ValueError('Non-adapter compiler unexpectedly owns TMP')
        source=original(root)
    else:
        if key not in files:raise ValueError('Adapter compiler omits TMP renderer')
        source=Path(directory)/key
        actual=pin(source)
        if actual!=files[key] or actual['sha256']==ORIGINAL_SHA:
            raise ValueError('Compiled adapter renderer differs or is original')
    return source,pin(source)

def copy_notices(root,destination):
    """Only indispensable licenses; never copy fonts, source trees or models."""
    import shutil
    root,destination=Path(root),Path(destination)
    selected={
        'tools/complex_text/vendor/BidiSharp/LICENSE':'BidiSharp-MIT-LICENSE.txt',
        'tools/complex_text/vendor/Unicode-17.0.0/LICENSE.txt':'Unicode-17-LICENSE.txt',
        'localization/fonts/complex-sources/OFL-1.1.txt':'Complex-fonts-OFL-1.1.txt',
        'localization/fonts/complex-sources/NOTICE.txt':'Complex-fonts-NOTICE.txt',
    }
    for source,target in selected.items():
        path=root/source
        if not path.is_file():raise ValueError('Required renderer notice missing: '+source)
        shutil.copy2(path,destination/target)
