# Exact immediate comparison operands

This source supplement resolves the operand role of 1,121 original `ldstr`
occurrences. Of those, 1,113 were still unclassified in the phase133 inventory;
the other eight overlap retained classifications. It does not overwrite the
active technical lane's inventory or grant common-source admission.

The Sol/high coordinator authored five exact consumer rules: string equality,
inequality, substring containment, substring position, and regex matching. In
each selected occurrence, `ldstr` is immediately followed by that exact call.
The IL instruction sizes and indices are checked, so the literal is the call's
last string argument. It is a comparison/search/pattern operand and must stay
exact. The proof does not depend on English-looking wording, method names, or
the return value being followed by a particular branch.

`preserve-exactly.jsonl` records every distinct assembly/method/offset identity,
exact source-value hash, consumer offset/opcode/signature, role, and reason.
It contains no translated wording or configuration credentials. `verification.json`
binds the original assembly identity, complete exported literal index, inspecting
script, all counts and output bytes. The original DLL is not opened or executed.
The previously reproduced Cecil index is checked against its recorded digest.

This is an immediate-argument proof, not a whole-method review. It says nothing
about the other argument's origin or the native implementation's execution.
Comparisons against displayed text can need a separate adapter: preserving the
English haiku search operands alone does not keep translated selected lines on
the same branch. Those complete source/control groups remain the owning source
and special-case gate's responsibility. Display occurrences elsewhere retain
their own IDs and decisions.

Check the complete delivered set without writes:

```sh
python3 -B localization/source/shared-source-completion-20261028/comparison-operands/verify.py
```

`--write` is for first creation only and refuses existing outputs. The two
sequential exclusive writes are not a transaction. A matching positive control
and changed-value/changed-consumer controls check the intended comparison
boundary; they do not simulate the renderer. No game, GUI, model job, texture,
font resource, original installation, save, or active language input is changed.

Regression: a changed substring operand must fail even with identical IDs,
length and call signature; changing the consumer to string concatenation must
fail before a protected-comparison classification can be emitted.
