"""Run the existing real-resource suite with German added to its locale sequence."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import argparse

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
work = ROOT/'dist/all30-inventory-work'
parser = argparse.ArgumentParser()
parser.add_argument('--run', default='01')
args = parser.parse_args()
assert args.run.isalnum()
source = ROOT/'MacOS/Tests/CoreTests.swift'
text = source.read_text()
before = 'let sequence = real ? ["hi", "sw", "uk", "ru", "en"]'
after = 'let sequence = real ? ["de", "hi", "sw", "uk", "ru", "en"]'
assert text.count(before) == 1
snapshot = work/('MacCoreTests-' + args.run + '.swift')
assert not snapshot.exists()
snapshot.write_text(text.replace(before, after))
binary = work/('MacCoreTests-' + args.run)
subprocess.run(['swiftc','-swift-version','6','-warnings-as-errors','-parse-as-library',
    '-target','arm64-apple-macosx14.0',str(ROOT/'MacOS/Sources/InstallerCore.swift'),
    str(snapshot),'-o',str(binary)],check=True)
fixture = work/('macos-actual-' + args.run)
assert not fixture.exists()
fixture.mkdir()
shutil.copytree(ROOT/'dist/Forest Languages 1.1.2.app/Contents/Resources', fixture/'Resources')
subprocess.run([str(binary),str(fixture),'/Applications/TheForestOfLove.app','--real'],check=True)
h = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
(HERE/('macos-test-inputs-' + args.run + '.json')).write_text(json.dumps(dict(
    shippingCoreSha256=h(ROOT/'MacOS/Sources/InstallerCore.swift'),
    originalSuiteSha256=h(source), configuredSuiteSha256=h(snapshot),
    onlySuiteChange=dict(before=before,after=after),
    locales=['de','hi','sw','uk','ru','en'],
    boundary='Actual unchanged shipping Swift core and native payload; isolated owned copies; no game execution'),indent=2)+'\n')
