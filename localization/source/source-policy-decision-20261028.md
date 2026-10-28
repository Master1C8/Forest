# Pending source preservation policy

This is a proposed source-scope decision, not an accepted gate or new translation.
The exact enumerations and fingerprints already exist in the shared source
products referenced by the [finite corpus handoff](../fonts/final-corpus-bindings-20261028/ADAPTER.md).
Do not regenerate or rewrite them merely to record this decision.

| Remaining family | Enumerated candidates | Proposed treatment |
| --- | ---: | --- |
| Dialogue database Title keys | 934 | Preserve original identity/metadata values |
| Conversation custom-field values | 716 | Preserve original metadata values |
| Conversation Description markers | 5 | Preserve original markers |
| Rewired backend labels/aliases and control identities | 1,344 + 45 | Preserve original system/controller values |
| Compiled static selectors at source lines331/332/4948 | 3 | Preserve original technical values |

The proposed exception preserves these values even if an external/backend UI
surfaces one. It does not assert that they are dead or can never be displayed.
Confirmed game-display prose is outside this exception. A newly observed ordinary
display use must be registered separately while preserving its underlying key.

The48 InventoryItem descriptions and four InventoryInfoTicker empty-cell strings
remain translation work. Their omission is not excused by this policy. Existing
source traces identify the title/description consumers and exact fallback
operands. Shared inventory admission, immutable target delivery, editorial and
font/runtime checks must still complete before a release claim.

Owner decision is pending. Until it is recorded, retain the current source-policy
holds and frozen old935/all30/dialogue inputs. Approval of the Steam bottle restart
does not resolve this separate preservation-policy question.
