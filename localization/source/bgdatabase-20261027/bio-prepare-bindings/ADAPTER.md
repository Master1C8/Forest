# Exact original prepare and scene-event bindings

Phase0082 is an append-only, text-only source supplement for the126 BIO target
registrations. It authors no translation and changes no original/frozen inputs.
Parent alone owns Git integration. Parallel locale assets/editorial lanes and the
actual Russian preview remain independent and untouched.

`source-trace.json` records original instruction locators. `il-commands.json`
retains successful selections and the one failed selection of a nonexistent
`DialogueSystemEvents.OnPrepareConversationLine`. The actual list excludes that
method; the failure is retained rather than retried. The small `FindPrepare.cs`
helper scans exact method definitions in the150 installed DLLs using Mono.Cecil.
It never loads game assemblies for execution. Its inputs are individually pinned.

## Preparation receiver

For a nonnull entry, `GetState` calls `DialogueManager.instance.SendMessage` with
the exact entry reference and option1 (`DontRequireReceiver`). This is before the
displayed mark, Lua setup, userScript/onExecute, actor/conversant resolution,
scene-event lookup and subtitle construction. `skipExecution` does not skip this
preparation message. The three-argument Component.SendMessage is a Unity native
InternalCall; this supplement does not execute or accept native dispatch.

`DialogueManager.instance` caches the result of `FindObjectOfType<DialogueSystemController>`
when its cached Unity object compares null. Runtime static initialization clears
the cache; controller Awake does not assign itself to it. The controller's Awake
can destroy its own GameObject when allowOnlyOneInstance is enabled and multiple
controllers are found. Static source identity therefore cannot select the live
receiver.

The complete exact-name metadata scan finds one preparation definition:
`ConversationLogger.OnPrepareConversationLine`. On nonnull entry it reads current
dialogue text and logs it; its body contains no entry setter/store or event forward.
`DialogueSystemEvents` and the two serialized controller/events wrappers do not
declare preparation handlers. This does not certify arbitrary later-loaded code,
native invocation, runtime additions, scripts or successful callbacks.

The existing202308-object inventory selects one serialized controller candidate,
`sharedassets0.assets:4608`, on GameObject1297 named DialogueManager. Its six attached
components are read from original bytes and compared with exact exports using the
existing header-aligned schema reader. The initial database points to3336. No
ConversationLogger or DialogueSystemSceneEvents component occurs among these six;
neither class has an instance in the existing inventory. These are inventory facts,
not a claim that no object can be created or selected during play.

## Scene lookup

The accessor uses exact field title `EventGuid`, not a scene/event-name heuristic.
`Field.LookupValue` returns the first exact field's value, or null if absent. It
does not substitute an empty string. All126 target registrations lack that field
in both frozen copies, so their unchanged-source accessor result is null.

`GetDialogueEntrySceneEvent` first resolves the separate sceneInstance cache. Its
getter uses FindObjectOfType on a null Unity object; Awake assigns itself, and the
public setter can replace it. A missing scene instance returns null. Otherwise
List.Find compares each event.guid with the supplied GUID using string equality.
There is no null/empty-GUID rejection before Find. In a supplied list, null can
match null and empty can match empty; absence of EventGuid alone does not prove
the scene event cannot be invoked.

When skipExecution is false, GetState resolves actor/conversant first and then
looks up the event. Its argument GameObject is the speaker transform's GameObject
when valid, otherwise the manager's GameObject. A nonnull event invokes onExecute
with that argument before subtitleText/Parse. Entry onExecute persistent lists are
empty, but that fact does not remove this independent scene-event path. Two
registrations still share108:116's mouse/treeId script.

## Reproduction and limits

Build only this metadata helper with the exact command in `execution-recipe.json`,
then run `verify_prepare.py --output <new-directory>` with `.venv-assets314/bin/python -B`.
The verifier preserves the frozen pin/helper/installed-resource chain, all12246
candidate values in both copies, and exact phase81 readbacks. It also replays the
successful metadata queries, reproduces the150-DLL scan, checks exact target-entry
identity and reads the original serialized candidate directly. Historical failed
selection is validated against its retained error and actual method list, not retried.

Synthetic controls replace .NET list/string operations and Unity scene resolution
with supplied Python inputs. They establish transcription behavior only. Actual
language/manager/scene/participant selection, Lua and transient listeners, callback
success, Subtitle delivery/rendering, BIO success and story reachability remain
unaccepted. No runtime, image, GUI, save or game-process interaction occurred.

Previous README/CHECKPOINT bytes are archived unchanged. Summary updates are two
separate writes, not a transaction; `summary-preservation.json` verifies retained
sections. Complete source/special-scene, universal semantic/independent diff/delta,
fonts/resources/package/runtime and local delivery gates remain pending. Accepted
10/15/47/48 visuals and route50 retain only their prior exact scope. No53 replay or54.
Worker token usage is unknown; parent measures telemetry.
