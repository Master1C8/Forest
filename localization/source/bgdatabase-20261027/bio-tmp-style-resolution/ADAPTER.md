# TMP style selection and default creation

The Forest of Love 0.45, standard Russian localization; static technical phase0097.
This append-only supplement reads original metadata/IL without executing original
assemblies or native code. `execution-model.json` verifies the actual ancestor CLI:
gpt-6.1-sol/high/OpenAI and ignore-user-config, before the known output-path option
boundary. No following prompt/history was loaded. No workers or nested model jobs.
Parent alone owns Git/index/HEAD and integration. All parallel asset/editorial/
Japanese lanes and the actual preview remain authorized, independent and read-only.

## Inputs and scope

Reuse phase96 input parsing and prior source evidence by hashes. Original module:
`Unity.TextMeshPro.dll`, SHA256
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
Original `UnityEngine.CoreModule.dll` resolves the resource and object-null helpers,
SHA256 `32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`.
Metadata comes from the pinned original install's Managed directory, read through
frozen InspectMethods and Mono.Cecil. .NET SDK is8.0.131. No installation/save writes.

Exact signatures select GetStyle(Int32), NormalStyle, their managed style lookup/
creation/hash dependencies, stack SetDefault, Unity object comparisons and the
resource-loading boundary. Raw incidental String lookup, UInt32 uppercase and
nongeneric one-argument Resources.Load exports remain pinned but are excluded from
the selected metadata/operand trace. Both SetDefault overloads are indispensable:
the static array overload calls the per-stack instance overload.

## Verified conditional flow

`TMP_Text.GetStyle(hash)` starts with managed-null result. If the component sheet
passes Unity Object inequality with null, its Int32 lookup runs. A managed-nonnull
style returns immediately; a miss proceeds to the settings default sheet. The default
getter is evaluated for its Unity-null check and again before its lookup; the first
object is not retained across both evaluations. TMP_Style derives from System.Object,
so the returned style test is managed null, distinct from sheet/settings Unity tests.

Original Object equality/inequality call CompareBaseObjects. Against null, managed
null is handled first, otherwise IsNativeObjectAlive tests GetCachedPtr()!=IntPtr.Zero.
GetCachedPtr reads m_CachedPtr. No native lookup is executed for these bodies. This is
specific to the pinned original CoreModule, not an assumed Unity version's behavior.

The default-sheet getter calls TMP_Settings.instance then directly reads its field,
without checking the returned instance. The instance getter reloads `TMP Settings`
through Resources.Load<TMP_Settings> when its cached Unity object compares equal to
null. It stores and returns the load result without a success check. Thus a managed
null result can fail at the subsequent field read before get_textStyle reaches its
NormalStyle fallback. Missing settings are not proven safe. Malformed style data,
allocation, callbacks and resource exceptions can also interrupt this route.

The sheet Int32 lookup initializes its dictionary only when the dictionary field is
managed-null, then calls TryGetValue. A miss returns managed null. Initialization
creates or clears the dictionary, visits the serialized list in order, RefreshStyle
on EVERY element, and inserts only absent integer hashes. The first entry for a hash
wins, with no name-equality collision check. Later duplicate elements are still
refreshed. A missing Normal hash causes a newly constructed Normal/empty/empty style
to be appended to the list and dictionary. An existing entry under that hash prevents
this addition regardless of its name/definitions. This is mutation, not pure lookup;
no live list, duplicate or collision was inspected.

NormalStyle independently lazily constructs and caches a managed Normal/empty/empty
style. Its construction route differs from the sheet's newly constructed Normal.
Constructor stores name/definitions and invokes RefreshStyle. Refresh recomputes the
name hash and separately allocates Int32/UInt32 arrays for opening and closing
definitions, copying each UTF16 code unit. It performs no surrogate scalar conversion
or markup validation in this body. Empty initial definitions create zero-length
arrays after successful construction. This does not prove the later cached shared
object stays unmodified or that installed custom styles are empty.

GetHashCode starts at0, applies `(hash<<5)+hash XOR mappedChar` per UTF16 unit with
ordinary Int32 operations. ToUpperASCIIFast(Char) uses a128-character literal table
in range; higher code units return unchanged. ASCII letters map to uppercase; this
does not provide Unicode case folding. Metadata-derived Normal hash is3111473395
(signed -1183493901). `derived-hash.json` computes it from literal/operations without
invoking original methods; it is not evidence of current installed style identity.

The static stack SetDefault visits every stack in the supplied array. Per stack,
only a null itemStack allocates capacity4 and initializes m_DefaultItem to default(T).
Both paths then write the supplied item to slot0 and set index1. Existing storage
and other slots are retained; there is no general stack clearing or capacity repair.
Phase96 supplies0 for the style stacks, then resets style depth separately. No
selected managed body has a local catch/finally or rollback: partial mutations on
failure remain possible; exceptions in callers/BCL/native code were not executed.

## Resource boundary

Resources.Load<T> passes typeof(T) to Load(String,Type), then casts/unboxes the result.
The typed overload gets ActiveAPI and calls virtual ResourcesAPI.Load(String,Type).
ActiveAPI prefers a managed-nonnull override backing field, otherwise s_DefaultAPI.
The selected base virtual body calls ResourcesAPIInternal.Load(String,Type), an
original InternalCall declaration with no managed body. This native path is conditional
on the chosen implementation; the actual API object, its override, initializers,
resource selection, loading success and serialized definitions remain unverified.
Resources were only hashed for retained parity, never decoded or used for loading.

## Reproduction and acceptance

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-style-resolution/verify_style.py --output localization/source/bgdatabase-20261027/bio-tmp-style-resolution/<new-output-directory>
```

Sixteen exact selections reproduce24 declarations:23 managed bodies and1 native
declaration;31 direct TMP/Unity method operands and55 field operands resolve to
original pinned modules.26 BCL/runtime method operands are explicitly opaque, not
executed.8 next declarations are pinned without reading their bodies;3 type identities
and zero local exception handlers verify.22 substantive data outputs regenerate plus
the verification report. Three raw/exact positive controls exclude incidental overloads.
All150 original DLLs and630 retained unique files verify, including37 phase96 files.
No mocks, original assembly execution, game/GUI/preview interaction, images opened,
authored translations, competing overlay or Git mutation.

Previous README/CHECKPOINT bytes are archived exactly. Existing checkpoint sections
remain unchanged except nextAction/updatedAt; one new static evidence section is
added. Previous current README summary moves to its exact archive; all following
README bytes remain. The two summary writes are separate, not a transaction; current
hashes are checked before each write. Parent receives an exact path/SHA256 manifest.
Usage is unknown to this worker; parent measures it.

Next read only exact opening-style expansion and TextBackingContainer markup hash,
then indispensable direct expansion/stack dependencies. Inline/closing helpers and
the concrete TextMeshProUGUI.SetArraySizes override remain pinned/unread. Do not
substitute the base TMP_Text body or dump GenerateTextMesh/read font/material resources.

All phase79–96 source/GetState/formatter/null-GUID/participant/cache/Transform/Lua/
language/reset/singleton/table/reentrancy/serialized-state/native-selection/conditional
UI/write/coroutine/notification/queue/pre-render/parsing limits remain. Actual controller/
DB/Lua/metatables/language/loading/save/global scripts/callbacks/delivery/rendering/BIO/
reachability, complete source/special-scene/runtime manifest, serializer/nonlinear
restore, Quest ordering/reflection/initial-unlock/counter, universal semantic/independent
diff/delta, final fonts/licenses/resources/runtime/delivery remain pending. Accepted
10/15/47/48 visuals and50 route remain unchanged; spawn/other3 intros/notebook/Bucky
stay open. No53 replay/no54. Owner provisional drafting/preliminary editorial exceptions
do not pass source/renderer/editorial/resource/delivery gates. No publication/deployment.
