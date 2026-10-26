#!/usr/bin/env python3
"""Supplement original BunnyHouse wall polygons and bounded natural route evidence."""
import hashlib
import json
from pathlib import Path
import UnityPy

ROOT = Path(__file__).resolve().parents[1]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
OUT = ROOT / 'localization/source/doorway-route-20261026'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    assert not OUT.exists()
    pins = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    assert sha(DATA / 'level3') == pins['level3']['sha256']
    objects = {o.path_id: o for o in UnityPy.load(str(DATA / 'level3')).objects}
    transforms = {i: o.read_typetree() for i, o in objects.items() if o.type.name == 'Transform'}
    rows = []
    for i, obj in objects.items():
        if obj.type.name != 'PolygonCollider2D':
            continue
        tree = obj.read_typetree()
        game_object = tree['m_GameObject']['m_PathID']
        transform = next(i for i, t in transforms.items() if t['m_GameObject']['m_PathID'] == game_object)
        chain = []
        while transform:
            t = transforms[transform]
            go = objects[t['m_GameObject']['m_PathID']].read_typetree()
            chain.append(dict(name=go['m_Name'], active=go['m_IsActive'], position=t['m_LocalPosition'],
                              scale=t['m_LocalScale'], rotation=t['m_LocalRotation']))
            transform = t['m_Father']['m_PathID']
        assert all(r['position'] == dict(x=0., y=0., z=0.) and r['scale'] == dict(x=1., y=1., z=1.) and
                   r['rotation'] == dict(x=0., y=0., z=0., w=1.) for r in chain)
        rows.append(dict(pathId=i, chain=chain, tree=tree))
    assert {r['pathId'] for r in rows} == {255, 256}
    speed_source = ROOT / 'assets/source-v2/trees/8f371d340c-sharedassets4.assets-35499.json'
    speed = json.loads(speed_source.read_text())['speed']
    assert all(abs(v-1.2) < .0001 for v in speed.values())
    OUT.mkdir()
    (OUT / 'wall-polygons.json').write_text(json.dumps(dict(source='level3', sourceSha256=sha(DATA / 'level3'), polygons=rows), indent=2)+'\n')
    inputs = ['localization/source/travel-20261026/doorway-geometry.json',
              'localization/source/travel-20261026/input-configuration.json',
              'localization/source/tutorial-20261026/PlayerMovement.il',
              'localization/source/tutorial-20261026/Doorway.il',
              'localization/probes/ru-20261026-33/post-movement-travel.json', str(speed_source.relative_to(ROOT))]
    trace = dict(scope='Supplemental original doorway route; frozen shared source inventories/glossaries unchanged',
        inputs={p: sha(ROOT / p) for p in inputs}, recipeSha256=sha(Path(__file__)),
        wallPolygonsSha256=sha(OUT / 'wall-polygons.json'),
        finding='RightCollider255 occupies the bottom-right corridor, including X~3.35 below Y~.6. Direct down at intro X is not a clear route. Left256 ends at X2.023 near the doorway; right255 begins at X2.949. Original root radius.16 leaves a corridor around X2.30–2.65.',
        route='At original intro Y~1.29, move left into X2.30–2.65, targeting2.50; then move down to enabled Doorway257 at Y.183 (top.293). Retain root/child topology. Read-only root Collider.Cast checks actual loaded obstacles before every pulse; static polygons alone do not prove loaded clearance.',
        keyboard='Original map0: action0 LeftArrow276 negative; action1 DownArrow274 negative. Native macOS virtual keys123/125 respectively. Observe all8 original movement keys in4 producer layers. No focus/map/axis/state changes.',
        speedSource=dict(path=str(speed_source.relative_to(ROOT)), speed=speed,
                         applicability='Source prefab candidate only; require actual loaded Player speed/currentSpeed1.2 in both axes before route'),
        bounds=dict(position='X2.30–3.55,Y.20–1.40; horizontal only at Y>1.20; descent only at X<=2.65',
                    pulseMilliseconds=[150,400], legMilliseconds=2400, totalMilliseconds=4800, totalPulses=16,
                    rationale='Each geometric leg is under1.35 units, nominal walking time under1.125 seconds at1.2. Each leg cap2.4sec allows bounded native ingress latency, with immediate stop for non-progress/blocked or changed guards. Position and real cast are re-read each pulse; elapsed time never establishes clearance or arrival.'),
        acceptance='Source trace and route plan only. Native down, loaded casts, movement/collision/scene transition remain runtime-unverified. Stop at first recorded CentralForest/automatic tutorial; no tutorial action.',
        regression='Same actual33 topology plus mocked casts: left-before-down, positive clear cast, matching blocker rejection, truncation rejection and time-cap rejection. Task UP recovery requires actual same-PID/window task DOWN receipt, never merely attempted=True.', imagesOpened=0)
    (OUT / 'source-trace.json').write_text(json.dumps(trace, indent=2)+'\n')
    print('Pinned original wall polygons and bounded natural doorway route:', OUT)


if __name__ == '__main__':
    main()
