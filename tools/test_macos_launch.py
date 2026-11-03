#!/usr/bin/env python3
"""Test direct native process launch with stubs. Never runs Forest or its app UI."""
import argparse
from pathlib import Path
import subprocess

ROOT=Path(__file__).resolve().parents[1]
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--run',required=True);a=p.parse_args()
    assert a.run.isalnum()
    work=ROOT/'dist/macos-installer-work';work.mkdir(parents=True,exist_ok=True)
    target=work/('direct-launch-'+a.run);assert not target.exists(),'Preserve an existing test run'
    target.mkdir();binary=work/('LaunchTests-'+a.run)
    subprocess.run(['swiftc','-swift-version','6','-warnings-as-errors','-parse-as-library','-target','arm64-apple-macosx14.0',
        str(ROOT/'MacOS/Sources/InstallerCore.swift'),str(ROOT/'MacOS/Sources/GameLauncher.swift'),str(ROOT/'MacOS/Tests/LaunchTests.swift'),'-o',str(binary)],check=True)
    subprocess.run([str(binary),str(target)],check=True)
