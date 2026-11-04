# Inventory headings across all 30 translations

The owner expanded the Russian inventory-heading repair to every language on
2026-11-04. Russian and German still used the v1 selector catalog; the other 28
languages already contained all twelve heading layers. Russian was delivered in
launcher 1.1.1. This continuation prepares the complete 1.1.2 delivery.

`initial-inventory.json` records all current language bindings after the Russian
repair. `all30-readback.json` binds all 720 actual heading fields: 30 languages,
two platforms, twelve layers each. Unchanged wording is retained. German adds
only `<size=22>I</size>NVENTAR` / `<size=30>I</size>NVENTAR`; all 14,594 existing
German entries and all other serialized fields remain unchanged. Its source
recipe reproduces the exact current JSON from Git commit
`5f7a4b1bb6d41399017f4e78e8df433390ce750c` and the twelve authored fields.

Both platform packagers now reject missing selectors, empty/English targets,
duplicate packed locales and stale packed language hashes. The native launcher
also rejects an owned but outdated selected-language resource version before
launch. Its normal Apply language route upgrades those files. A changed overall
payload with identical selected resources remains valid. Tests exercise both
the negative launch case and a real upgrade from the old owned state, rather
than merely retrying from a fresh copy.

The initial Windows payload refresh used one oversized literal segment. The
shipping materializer rejected it before applying localized resources. That
attempt and its rejected artifact are recorded in `windows-attempts.json`.
The corrected recipe uses segments of at most 65536 bytes, matches the actual
shipping manifest reader, and checks every reconstructed resource. Exact
unchanged bundle roundtrips are retained. The old archive/manifest/receipt
triplet is preserved before publication; replacements are not a transaction.
Failure tests cover interruption after archive and manifest replacement.

The prior full normal Windows payload job was allowed to finish with unchanged
inputs before German was published. Its frozen output was then refreshed through
the common deterministic mechanism. No old locale/model worker was resumed and
no additional model or reviewer was started.

The native input recipe now pins its actual resource-receipt input instead of an
unused historical Windows-installer payload reference. That metadata correction
does not change native payload/resource bytes. Final app source pins include the
shared selection/configuration and heading guard.

Static field readbacks, actual isolated installations, source/package identity,
save/settings preservation and launch-version rejection have separate receipts.
The owner has not checked the Russian rendered heading (`Пока не проверял`). No new
multilingual game screenshot review was performed. Font shaping, clipping and
all-language native visual acceptance are not inferred from these checks.
Independent review of the two newly supplied heading words was not commissioned.
Existing Russian owner acceptance and prior locale evidence remain unchanged.

Whole-project source-only archival remains pending: this finite repair does not
close the multilingual project's remaining native/human acceptance gates. There
is no public release/site publication or deployment in this task.
