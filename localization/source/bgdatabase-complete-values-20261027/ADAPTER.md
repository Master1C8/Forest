# Complete BGDatabase value inventory

This append-only supplement fills the previous43,759 unenumerated cell states without changing any active dialogue/glossary/locale input or technical root document. The pinned exported payload is506,640 bytes, SHA25641834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9. No game or original assembly is executed, no installation/saves are written.

All29 tables,3,052 rows,289 fields and51,572 cell states are enumerated with exact sheet/row/field IDs, typed/opaque values, stored-vs-absent state and physical byte spans. All7,813 prior classified states match their exact decoded-value hashes and existing selector strings. The ledger preserves40,480 further scalar/relation/resource/list states as typed technical bytes.3,279 text states still require actual consumer classification:3,263 stored nonempty strings,3,959 whitespace-delimited words across29 columns. These are pending source candidates, never newly accepted translation input. The field-level list is in readback-validation.json.

The frozen local envelope reader and independently authored original glossary reader both consume the complete source and agree on identifiers, ordering and all289 raw field blobs. verify_complete.py independently compares all51,572 delivered states to the second decoder:12,457 scalar/text values,2,629 normalized relation IDs,2,667 opaque typed raw values and33,819 absent states. Opaque lists/resources are byte-verified rather than assigned invented meanings. Reconstruction from delivered cell rows and recorded sparse ordering restores every field blob and the exact whole payload. This replaces neither Unity/engine reinsertion nor runtime verification.

Matched controls verify explicit stored empty text versus absent state, out-of-range sparse row index, bad cumulative end, duplicate row index and invalid stored UTF-8 at the actual decoder boundary. Two normal complete extractions reproduce all three delivered data artifacts byte-for-byte. Scripts never generate translations or semantic verdicts.

Run from the canonical Forest checkout:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 localization/source/bgdatabase-complete-values-20261027/extract_complete.py --output /absolute/fresh/output-directory
PYTHONDONTWRITEBYTECODE=1 python3 localization/source/bgdatabase-complete-values-20261027/verify_complete.py
```

The extractor refuses to overwrite an existing extraction. The checker targets the preserved verified ledger and writes only its owning readback report. Historical family matrices remain immutable; their43,759 missing-state count is superseded only for value enumeration, not consumer/source acceptance. Next work must classify the29 remaining text columns from concrete existing game consumers, retain exact controls/keys and discover any special-scene dependencies. Complete game inventory, font/UI binding, source/locale decisions, renderer and release gates remain OPEN.
