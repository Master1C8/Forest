# Exact TMP input parsing before array sizing

Phase0096 is text-only original metadata work in canonical Forest. Ancestor CLI
options verify gpt-6.1-sol/high/OpenAI and ignore-user-config; no prompt/history
tokens after the known output-last-message option/value were parsed or emitted.
The initial option assertion expected the short -m spelling and failed before
metadata work; verification was corrected for the actual --model option.
Parent alone owns Git/index/HEAD. All parallel asset/editorial/Japanese lanes and
the actual Russian preview remain independent/read-only. No agents, nested model
jobs, original assembly execution, game/GUI/images, overlays or publication.

## Input and conversion

Original Unity.TextMeshPro.dll SHA256 is
775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483.
ParseInputText routes TextInputBox0 and TextString3 through optional
ITextPreprocessor.PreprocessText(m_text), string backing copy and processing-array
conversion. SetText1/SetTextArray2 and other values skip that conversion and still
call virtual SetArraySizes. The retained setter uses3; live state is unexecuted.

The preprocessor return value, rather than an assumed unchanged original string,
is consumed. The selected bodies do not store m_text, but an unknown callback may
mutate/reenter/throw or change inputSource. No concrete preprocessor is identified.
Null returned input takes the backing copy's zero-length branch. UTF16 code units
are copied into UInt32 backing slots; zero termination precedes Count storage.

Processing clears style-stack defaults/depth, resolves text style, conditionally
inserts opening style, then loops to Count or the first zero code unit. The escape
dispatch is guarded by current inputSource==0. Thus source3, if not changed by a
callback, bypasses backslash-n/r/t/v and u/U decoding in this block. Actual newline
code units still pass through. This does not certify upstream/later parsing.

Surrogate pairs are handled after that guard, for all routes reaching conversion:
an in-range high/low pair becomes a scalar with backing stringIndex/length2;
ordinary units retain their index/length1. Unpaired units fall through; no general
Unicode validation or replacement guarantee is inferred. Rich-text hash dispatch
can emit LF/NBSP/ZWSP or call style expansion helpers. Those helpers and the hash
algorithm are pinned but unread: exact tag grammar and expansion remain open.
Default styles can also expand input without an inline rich-text tag.

Closing style insertion precedes the final unicode0 sentinel and internal-size
store. No selected managed body has a local catch/finally or rollback; array/state
writes may be partial on failure. Processing indexes describe backing input and
are not proven offsets in original m_text after preprocessing/style expansion.

## Exact boundaries

Both backing and processing growth call native Mathf.NextPowerOfTwo and managed
System.Array.Resize. NextPowerOfTwo resolves original CoreModule as InternalCall,
without a body; no native call or original allocation was executed.

get_textStyle stores GetStyle(hash)'s return, with a managed-null NormalStyle/hash
fallback. GetStyle/NormalStyle bodies and all current resources remain unread.
Parser always calls SetArraySizes after successful optional conversion and discards
its result. Concrete TextMeshProUGUI declares the exact override; do not substitute
the base virtual body. Font/sprite/material lookup, generation and rendering remain
unaccepted. No original font3323/material7/Canvas/component resource was decoded.

## Reproduce and verify

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-input-parsing/verify_input.py --output localization/source/bgdatabase-20261027/bio-tmp-input-parsing/<new-output-directory>
```

Frozen InspectMethods is reused, with exact signature projection. Its incidental
StringBuilder/Char[] backing overload exports are preserved separately and excluded
from the selected method bodies and operand trace. Raw/exact positive controls
verify this exclusion. The new InputScopes helper reads original Cecil metadata,
exact dispatch declarations, enum values and exception tables; it never loads or
invokes original managed code.

Seven exact selections reproduce16 declarations:14 managed bodies,1 abstract
interface and1 native declaration.54 direct TMPro/Unity method operands resolve;
one concrete dispatch chain and zero local exception handlers are verified.
Ten substantive data outputs regenerate, with an additional verification report.
All150 original DLLs and593 unique retained files retain hash parity, including
54 phase95 files, prior supplements,19 frozen pins,7 owning helpers,7 process
references,10 installed files and183 inherited inputs. Installed resources were
hashed, not decoded. Existing source/renderer computations are retained by hashes.

README/CHECKPOINT previous bytes are archived exactly. Summary writes are separate,
not transactional; preservation is checked per section, including preliminaryEditorial,
russianActualPreview,parallelLocaleDrafts and localeStatus. Parent receives exact
project-relative paths/SHA256 values for integration. Worker usage is unknown;
parent measures it. Metadata validation proves static flow only, with no mocks.

## Next bounded consumer and acceptance

Read exact GetStyle(Int32)/NormalStyle and indispensable direct style lookup to its
next native/resource boundary, resolving modules. Do not decode font/material or
dump GenerateTextMesh. Concrete SetArraySizes remains a pinned subsequent consumer.
No current style/preprocessor state, glyph mapping or actual rendering is proved.

Retain all79–95 source/GetState/formatter/null-GUID/participant/cache/Transform/Lua/
language/reset/singleton/reentrancy/serialized-state/native-selection/conditional
UI/write/coroutine/notification/queue/pre-render limits. Actual controller/DB/Lua/
metatables/language/loading/save/global scripts/callbacks/delivery/rendering/BIO/
reachability, complete source/special-scene/runtime manifest, serializer/nonlinear
restore, Quest ordering/reflection/initial-unlock/counter, universal semantic/
independent diff/delta, final fonts/licenses/resources/runtime/delivery remain open.
Accepted10/15/47/48 visuals and50 route are unchanged; spawn/other3 intros/notebook/
Bucky remain open. No53 replay/no54, hierarchy dumps or competing overlays.
