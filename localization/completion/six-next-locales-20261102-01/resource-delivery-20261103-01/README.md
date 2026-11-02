# Six verified local Forest resource overlays

All six local resource overlays (bg, cs, el, fa, fil, he) have completed the normal
single-file compiler build and check. `index.json` binds each exact language input,
actual output directory, manifest, all16 resource sizes/hashes, independent wording
coverage and original terminal build/check receipt. The coordinator additionally
read and hashed all96 delivered resource files. No model request or game launch
was made for this final verification.

The normal build recipe remains `./forest-localize build <language.json>` followed
by the same output's `--mode check`; the four preserved finite build manifests
record the exact inputs. Do not rerun a completed build in place or replace its
input/hash merely to refresh a timestamp. Wording has12825 exact independent passes
per locale and1781 exact protected source states; protected states are not semantic
translation passes. Resource integrity does not establish target runtime behavior.

These are resource overlays, not accepted installers or releases. Native game,
font loading/shaping/bidi/fallback/layout/readability, original artwork, deferred
human glossary and release acceptance remain separately held. The whole project
is unfinished, so source-only archival/cleanup is pending and no GitHub write,
server action or owner game/save modification is authorized by this record.
