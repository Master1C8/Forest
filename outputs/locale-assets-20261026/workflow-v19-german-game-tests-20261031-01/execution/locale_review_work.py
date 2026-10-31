"""Shared model-free review preparation/publication. Never generates judgments."""
import argparse
import hashlib
import json
from pathlib import Path

from locale_queue import read, sha, local
from locale_efficiency import load_rows,canonical


def dump_rows(path, rows):
    with path.open('x') as f:
        for row in rows:f.write(json.dumps(row,ensure_ascii=False)+'\n')


def prepare_scope(root, packet, authored, directory, dependencies=None):
    """New authored versions + explicitly caused invalidations; context is separate."""
    root=root.resolve();packet=packet.resolve();authored=authored.resolve();directory=directory.resolve()
    if not all(p.is_relative_to(root) for p in [packet,authored,directory]):raise ValueError('Review work must stay in the canonical project')
    rows=load_rows(packet);changed=load_rows(authored)
    by_id={r['id']:r for r in rows};primary={r['id']:r for r in changed}
    if len(by_id)!=len(rows) or len(primary)!=len(changed) or not primary:raise ValueError('Nonempty unique source and authored IDs required')
    if not set(primary)<=set(by_id):raise ValueError('Authored IDs outside review packet')
    for ident,row in primary.items():
        for field in ['source','target']:
            if row.get(field)!=by_id[ident].get(field):raise ValueError('Authored version differs from packet')
            if not isinstance(row.get(field),str):raise ValueError('Literal source/target strings required')
            if hashlib.sha256(row[field].encode()).hexdigest()!=by_id[ident][field+'Sha256']:
                raise ValueError('Source/target content hash mismatch')
    causes=[];selected=set(primary)
    for dep in dependencies or []:
        if dep.get('id') not in by_id or not dep.get('reason') or not dep.get('causedBy') or not set(dep['causedBy'])<=set(primary):
            raise ValueError('Dependency needs a concrete cause in the authored changes')
        evidence=dep.get('evidence') or {};p=local(root,evidence['path'])
        if sha(p)!=evidence['sha256']:raise ValueError('Dependency evidence changed')
        selected.add(dep['id']);causes.append(dep)
    chosen=[r for r in rows if r['id'] in selected];context=[r for r in rows if r['id'] not in selected]
    directory.mkdir(parents=True)
    dump_rows(directory/'review-packet.jsonl',chosen)
    # Complete source strings remain readable; unchanged translations and technical
    # wrappers remain available by exact original row identity, not newly audited.
    dump_rows(directory/'source-context.jsonl',[dict(id=r['id'],source=r.get('source'),sourceSha256=r.get('sourceSha256'),
        originalPacket=str(packet.relative_to(root)),originalRowSha256=hashlib.sha256(canonical(r).encode()).hexdigest()) for r in context])
    scope=dict(primaryIds=list(primary),invalidatedDependencies=causes,reviewIds=[r['id'] for r in chosen],
        sourceContextIds=[r['id'] for r in context],sourceContextCoverage='Reference only; no new target-language acceptance or retired prior judgment',
        originalPacket=dict(path=str(packet.relative_to(root)),sha256=sha(packet)),
        authored=dict(path=str(authored.relative_to(root)),sha256=sha(authored)),
        boundary='Preserve all required source facts, joins, glossary/referent and runtime context. Open original bounded evidence when needed. Unbounded/missing dependencies require broader review, never silent pruning.',
        files=[dict(path=str(p.relative_to(root)),sha256=sha(p)) for p in [directory/'review-packet.jsonl',directory/'source-context.jsonl']])
    (directory/'scope.json').write_text(json.dumps(scope,ensure_ascii=False,indent=2)+'\n')
    return scope


def finish_review(root, phase, judgments, summary, context_complete, next_task=None, handoffs=None, output_name='review-output'):
    """Attach exact metadata to model-written judgments; keep missing IDs pending."""
    root=root.resolve();phase=phase.resolve();judgments=judgments.resolve();handoffs=[p.resolve() for p in handoffs or []]
    if not phase.is_relative_to(root):raise ValueError('Review phase must stay in the canonical project')
    config=read(phase/'task.json');task=config['task'];packet=local(root,task['reviewPacket'])
    if sha(packet)!=task['reviewPacketSha256']:raise ValueError('Assigned packet changed')
    rows=load_rows(packet);expected={r['id']:r for r in rows}
    if len(expected)!=len(rows):raise ValueError('Duplicate assigned IDs')
    supplied=load_rows(judgments);actual=[];seen=set()
    import run_locale_completion as runner
    runtime=read(phase/'runtime-verification.json') if (phase/'runtime-verification.json').exists() else None
    for judgment in supplied:
        ident=judgment['id']
        if ident in seen or ident not in expected:raise ValueError('Duplicate or foreign primary judgment; keep context notes separate')
        seen.add(ident)
        if not judgment.get('rationale') and not judgment.get('fidelityRationale'):raise ValueError('Actual model rationale required')
        if judgment.get('verdict') not in runner.REVIEW_VERDICTS:raise ValueError('Explicit supported model verdict required')
        row=dict(judgment)
        for field in ['sourceSha256','targetSha256']:
            if field in row and row[field]!=expected[ident][field]:raise ValueError('Judgment version differs')
            row[field]=expected[ident][field]
        if runtime:
            stamp=dict(reviewerThreadId=runtime['threadId'],model=runtime['actualRuntime']['turn']['model'],
                reasoning=runtime['actualRuntime']['turn']['effort'],provider=runtime['actualRuntime']['session']['model_provider'])
            for field,value in stamp.items():
                if field in row and row[field]!=value:raise ValueError('Supplied reviewer identity differs from actual runtime')
                row[field]=value
        actual.append(row)
    if not actual:raise ValueError('No model judgments supplied')
    carry=task.get('reviewCarryover');basis=local(root,carry['packet']) if carry else packet
    if carry and sha(basis)!=carry['sha256']:raise ValueError('Carryover basis changed')
    inherited=set(carry['pendingIds']) if carry else set(expected)
    judged={r['id'] for r in actual if r.get('reviewed') is not False}
    pending=inherited-judged
    if not context_complete and not pending:raise ValueError('Unread required context prevents a complete primary checkpoint')
    if Path(output_name).name!=output_name or output_name in {'.','..'}:raise ValueError('Output must be one fresh phase-owned directory')
    directory=phase/output_name
    if directory.exists() or (phase/'result.json').exists():raise ValueError('Publication exists; reconcile before writing again')
    # Validate every next input before starting publication.
    if not pending and not next_task:raise ValueError('Complete packet needs the actual next finite task; never imply whole-game readiness')
    remaining=[r for r in load_rows(basis) if r['id'] in pending]
    if len(remaining)!=len(pending):raise ValueError('Pending IDs escaped the frozen basis')
    directory.mkdir();dump_rows(directory/'reviews.jsonl',actual)
    dump_rows(directory/'pending.jsonl',remaining)
    (directory/'pending-ledger.json').write_text(json.dumps(dict(judgedIds=sorted(judged),pendingIds=sorted(pending),
        contextComplete=context_complete,acceptance='Model judgments only; missing IDs receive no verdict or acceptance'),indent=2)+'\n')
    if pending:
        brief=directory/'next.md'
        brief.write_text('''# Continue exact unread review

Read task.json and the frozen contract. Review the complete remaining assigned
source/target pairs with their required source/consumer/glossary context. Retain
matching prior judgments. Do not reread unchanged targets for taste. Write only
new judgments, then use the frozen locale_review_work.py finish-review command.
Missing rows remain pending; no default passes or whole-game acceptance.
''')
        next_task=dict(kind='review',taskClass='semantic-review',title='Finish the exact unread review IDs',
            brief=str(brief.relative_to(root)),reviewPacket=str((directory/'pending.jsonl').relative_to(root)),
            contextPackets=task.get('contextPackets',[]))
    output=dict(outcome='continue',summary=summary,reviews=str((directory/'reviews.jsonl').relative_to(root)),
        progress=dict(kind='reviewed',unitIds=sorted(judged)),
        evidence=[dict(path=str(p.relative_to(root)),sha256=sha(p)) for p in
                  [directory/'reviews.jsonl',directory/'pending.jsonl',directory/'pending-ledger.json']],nextTask=next_task)
    if handoffs:
        output['technicalHandoffs']=[dict(path=str(p.relative_to(root)),sha256=sha(p)) for p in handoffs]
        output['evidence'].extend(output['technicalHandoffs'])
    # The same owning gate checks transport and exact pending-version accounting.
    # This does not establish meaning or final acceptance.
    runner.validate_result(root,config['job'],phase,task,output,set())
    runner.save(phase/'result.json',output)
    return dict(judged=len(judged),pending=len(pending),result=str(phase/'result.json'))


if __name__=='__main__':
    parser=argparse.ArgumentParser();sub=parser.add_subparsers(dest='command',required=True)
    p=sub.add_parser('prepare-scope');p.add_argument('--packet',type=Path,required=True);p.add_argument('--authored',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--dependencies',type=Path)
    p=sub.add_parser('finish-review');p.add_argument('--phase',type=Path,required=True);p.add_argument('--judgments',type=Path,required=True);p.add_argument('--summary',required=True);p.add_argument('--context-status',choices=['complete','partial'],required=True);p.add_argument('--next-task',type=Path);p.add_argument('--technical-handoff',type=Path,action='append');p.add_argument('--output-name',default='review-output')
    args=parser.parse_args();root=Path('/Users/antonkrutov/Desktop/Forest')
    if args.command=='prepare-scope':
        result=prepare_scope(root,args.packet,args.authored,args.output,load_rows(args.dependencies) if args.dependencies else [])
        print(json.dumps(dict(primary=len(result['primaryIds']),dependencies=len(result['invalidatedDependencies']),sourceContext=len(result['sourceContextIds']),scope=str(args.output/'scope.json'))))
    else:print(json.dumps(finish_review(root,args.phase,args.judgments,args.summary,args.context_status=='complete',read(args.next_task) if args.next_task else None,args.technical_handoff,args.output_name)))
