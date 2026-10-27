# Complete item notification repair

The owner reported acquired items remaining in English. The current uninstrumented
Russian candidate is `localization/previews/ru-20261027-items-fixed/game/`, product
`ForestRuActual20261027_19`. Its data/code parent is menu-fix through item-fix;
its final layout parent is item-fix. Construction receipts remain immutable.
Later runtime and visual evidence is bound separately in `validation.json`.

## Finite source and all30 target inputs

`inventory.json` contains110 stable display IDs, shared by every target locale:
48 InventoryItem `title` cells,48 `notification_phrase` cells, eight display
operands in seven notification methods, and six serialized glitch-prefab labels.
The source reuses the verified48-row extraction; no frozen dialogue or glossary
was edited. Reproduce it with `tools/inspect_item_notifications.py --check`.

The loader copies both columns into runtime InventoryItem fields. Legacy
ItemGetNotification formats its notificationPhrase; dialogue received/delivered
controllers, OverworldItemGetNotificationLite and OverworldAllInOneNotification
consume title. The latter queues title and invokes the shared notification item's
found/received/delivered formatters. Original IL18–22,42–45 and52 remains in
`../bgdatabase-20261027/`; `code.json` pins exact assembly operands/offsets.
Branch1 skips Configure methods and displays the glitch prefab's six labels
directly. Its six question marks remain intentional source text. `Plank! <.<` is
another display override; three animator triggers `show` stay protected.

All ordinary item terms reuse each pinned approved glossary exactly. Placeholder
and seasonal-card variants have explicit wording in `item-wording.json`.
Acquisition labels accept standalone terms without retaining English articles.
The packet now contains556 records per locale /16,680 targets. Prior446 records
remain byte-exact prefixes in every locale; the intermediate550-record stage is
also preserved and checked. Independent editorial acceptance, other-locale fonts,
resources, shaping and runtime gates remain pending. This is not30 packaged games.
Inventory descriptions are an explicit separate untranslated scope.

## Shared mechanism and preservation

`russian_item_ui.py` patches only the two database columns, reads back all96 cells,
compares every other column across the database, and reverses to the complete
prior payload exactly. All16 other item columns retain their bytes, including
technical names, save keys, enum values, descriptions, asset references and flags.
Prior Actor/tutorial repairs remain intact. No ownership event or comparison is
translated. The managed repair starts from the accepted gallery assembly and
changes only eight display operands. Whole-method inventory readback and reversal
preserve branches, locals, handlers and every other method, including earlier
six gallery translations. The current patch tool reproduces the delivered assembly.

Both menu and gameplay controllers reference the same normal/glitch prefabs1284
and1279 in sharedassets1; `layout.json` pins their twelve TMP layers. Original
LayoutElements declare width210 but no layout driver applies it. Dummy20-unit
fields disable wrapping and allow glyphs to leave the viewport even when
`overflow=False`. Merely wrapping/inheriting those widths, or preserving their
left origins, did not constrain the actual right-anchored parent placement.

`placement.json` pins the final layout: two320-unit groups, two210-unit title
fields with right pivots/anchored x152 (eight units of right padding), and icon
rects at x−118. Ten nested face/glow rects inherit the same title width; all twelve
TMP fields wrap.28 objects change. Fonts, size16, original centered alignment,
stroke offsets, sprite pixels and scales stay intact. Complete selected-tree
readback and unselected raw-object equality pass. No texture is produced/replaced.
The final clone changes only this shared asset and its isolated identity relative
to item-fix; every other parent file remains byte-identical.

The full and incremental builders include the repair. A full dialogue/font rebuild
was not rerun; current projection/code-chain and layout readbacks reproduce the
delivered resources. Owner launch/progress still follows `localization/previews/PLAYER-LAUNCH.md`; no owner game is
restarted and no owner save is admitted to QA or copied into these artifacts.

## Runtime, capture and rejected evidence

The final isolated run10 compares all48 actual DataService items /96 strings,
calls real found/received/delivered methods, and stages the original glitch prefab
without a Configure call. It performs no award/removal or continuation action.
All six long-title layers have width210 and three lines; all four message kinds
report no overflow. Actual UI Camera white-glyph bounds after FadeIn completion
are inside2%..98% of the viewport. The long label spans x0.5077795..0.9135485;
the glitch label spans0.6654309..0.7554027. No coordinate is mislabeled as native
pixels. Native frames are1440×900; model inputs are separate1280×800 WebP80 copies.
Capture preflight and geometry do not substitute for the separate image judgments.
The bridge is removed and the localized assembly restored after task-owned exit.
Synthetic fixture bytes remain unchanged; it retains its original unverified
restore disposition. No owner-save continuation acceptance is claimed.

Rejected attempts remain private immutable evidence:01/03 stopped at a null test
JSON array before item comparison; disassembly disproved the initial timing
hypothesis, and explicit48-line UTF-8/base64 transport resolved that boundary.
02 exposed a stale diagnostic product constant.04 read data correctly but captured
a black ChapterSelect transition; its image review failed.05 exposed right-edge
clipping.06 was prepared but never launched after discovering direct glitch labels.
An item-complete build stopped at snapshot preflight before cloning/launch.
07 rejected wrapped fields still at width20 before capture.08 passed width/line
checks but both image reviews still failed positioning.09 took no images: eight
camera-projected samples per action proved stable off-screen bounds after the
0.75-second animation, ruling out a wait-only repair.10 applies the measured
parent/icon/text repair and viewport guards before capturing two new frames.
All completed runs exited/restored their own copies without owner data.

`retained-website.json` binds six source `TFoL.info` controls; website-consumer.il
binds original ShowWebsite to https://www.theforestoflove.com/. This exact website
identifier is retained in all locales. The painted game title remains the owner's
notify-only texture exception. Neither decision excuses other source fallback.

Regression tests reject changed before text/font/technical save keys, repeat
application and attempts to translate animator triggers. They verify both shared
prefabs' six-layer matching widths, exact all30 prefixes and approved glossary
bindings. A clean build or overflow=False alone never passes viewport/visual QA.
The native scope is these two Russian notification frames, not hosted/full-game,
all48 rendered item names, live award events, descriptions or other languages.

The final two affected native frames pass all five applicable image checks with
no open findings. Six Sol/high review requests, including all four rejected
judgments, are measured in validation.json; no translation worker or Astra ran.
