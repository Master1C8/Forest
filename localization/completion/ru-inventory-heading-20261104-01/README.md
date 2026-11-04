# Russian inventory heading repair

The owner reported `INVENTORY` in the native Russian game on 2026-11-04.
The launcher selected `ru-baseline.json`, whose immutable v1 framework omitted
twelve unchanged original heading layers. This is the same finite selector
omission already repaired by the existing shared v2 framework.

`prepare.py` copies the exact shipped Russian baseline to the current `ru.json`,
rebinds it to v2, and adds only the twelve heading translations with their
initial-letter size markup. All 14,594 previously shipped wording entries remain
equal. The previous unshipped `ru.json` terminology draft remains recoverable at
Git commit `11bfe3117a6fe15537973e222c87b28f49069386`; it is not the shipped baseline
and is not silently credited as accepted wording.

Both platform builders now follow the same configured Russian source override.
The immutable Russian baseline, framework snapshots, other locales and owner saves
are preserved. No worker or additional reviewer is started.

The normal compiler reports twelve changed units and sixteen output resources.
`verify_headings.py` checks the actual Windows and native macOS outputs: exactly
twelve changed serialized objects, only `m_text` changed in those objects, and
eleven other resource files exactly equal to the previous shipped Russian data.
The normal compiler and native adapter independently verify the remaining bundle
and catalog preservation. The existing dynamic fallback contains every required
Cyrillic character; font assets are unchanged.

`heading-readback.log` retains the first validation attempt, which failed to find
an external Unity script in a sparse overlay. The corrected validator resolves
script references through the verified original platform installation and passes
in `heading-readback-02.log`. This was a validator input-boundary failure, not a
failed resource build. Compilation success and resource/font checks are separate
from actual in-game visual acceptance.

Whole-project archival stays pending while the multilingual project's existing
native/human/owner-acceptance gates remain unfinished. This local defect repair
does not reopen accepted Russian dialogue or authorize publication/deployment.
