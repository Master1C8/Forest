"""Exercise real serial host/guards with mocked Unity, time and native delivery.

No game, image, keyboard event or model request is used. Native transport fixtures
cannot establish CGEvent/Rewired/Unity delivery; compiled/native gates stay separate.
"""
import copy
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

import test_bucky141 as graph
import test_bucky_interaction as admission
import test_tutorial181 as tutorial181
from test_save_continue import FIXTURE, PREFIX, loaded, tutorial, response, stamp

p=graph.probe


class World:
    def __init__(self, run):
        self.run=run; self.now=1.; self.frame=100; self.realtime=1.
        self.position=[6.,8.,0.];self.phase='menu';self.eid=153;self.menu158=False
        self.end=None;self.calls=[];self.native=[];self.recoveries=[];self.samples=[]
        self.last=None;self.inject=None
        self.identity=dict(company='VNRevivalQA',product='ForestRuRendererProbe',
            dataPath='Y:/Desktop/Forest/localization/probes/'+run.name+'/game/'+p.DATA,
            persistentDataPath='C:/QA/VNRevivalQA/ForestRuRendererProbe')
        self.target=dict(mode='inspect',pid=1234,windowID=5678,windowCount=1,candidateCount=2,accessibilityTrusted=True)
        for name,value in [('tutorial-prefix.json',PREFIX),('tutorial181-plan.json',tutorial181.PLAN),('bucky141-plan.json',graph.PLAN)]:self.save(name,value)

    def tick(self, seconds=.01):
        self.now+=seconds;self.realtime+=seconds;self.frame+=1

    def sleep(self, seconds):self.tick(seconds)

    def save(self, name, value):
        (self.run/name).write_text(json.dumps(value))

    def apply_identity(self, value):
        return dict(value,**self.identity,frame=self.frame,realtime=self.realtime)

    def approach(self):
        sample,state,rows=admission.fixture()
        sample=self.apply_identity(sample);state=self.apply_identity(state)
        rows['actor']['position']='7.8,6.3,0'
        rows['player']['position']=','.join(map(str,self.position))
        touching=self.position[0]>=7.72 and self.position[1]<=6.65
        scarlett=self.position[0]<6.3
        for key in ['controller','trigger']:
            rows[key]['touching']=str(touching)
            rows[key]['authorityId']=rows[key]['gameObject'] if touching else ('991' if key=='controller' else '992') if scarlett else '0'
        rows['collision']['rootTouch']=str(touching)
        interactions=[]
        for actor,path,identity,authority,touch in [('Scarlett',p.BUCKY_SCARLETT,'91',scarlett,scarlett),('Bucky',p.BUCKY_ACTOR,'21',touching,touching)]:
            interactions+=['interaction | path='+path+'/Interaction/InteractionUiController | id='+identity+' | active=True | enabled=True | authority='+str(authority)+' | playerTouching='+str(touch)+' | actor='+actor,
                'interactionTrigger | owner='+identity+' | active=True | authority='+str(authority)+' | touching='+str(touch)]
        if self.inject=='authority':interactions[0]=interactions[0].replace(p.BUCKY_SCARLETT,'wrong')
        packet=dict(interaction=admission.encode(sample,rows),state=state)
        packet['interaction']['diagnostics']+=interactions
        packet['interaction']['diagnostics'].append('buckyMotion | movement=True | lanternTransition=False | sweaterTransition=False | swim=null | waypoints=False | speed=1.2,1.2,0 | currentSpeed=1.2,1.2,0')
        return packet

    def state(self):
        if self.phase=='tutorial':
            if self.eid==158:
                result=tutorial181.menu(self.frame) if self.menu158 else tutorial(158)
            elif self.eid in p.TUTORIAL181_ROUTE:result=tutorial181.route(self.eid,self.frame)
            else:result=tutorial(self.eid,[response(154)] if self.eid==153 else [])
            result=stamp(self.apply_identity(result))
            if result.get('tutorial181Record'):
                row=json.loads(result['tutorial181Record']);row['frame']=self.frame;result['tutorial181Record']=json.dumps(row)
        elif self.phase=='bucky':
            result=self.apply_identity(graph.state(self.eid,self.frame))
            if self.inject=='source':result['conversationState']='Wrong'
        elif self.phase=='cleanup':
            result=self.apply_identity(graph.ended(self.frame,self.end))
        else:
            result=self.approach()['state']
            result.update(typing=False,entryId=0,conversationId=0,conversationState='')
        result.update(scaledTime=self.realtime,timeScale=1.)
        result['responseRecords']=[json.dumps(r) for r in result['responses']]
        result['responseCount']=len(result['responses'])
        self.last=result
        return result

    def saved(self):
        ready=dict(loaded(),diagnosticsReady=True,dataServicePresent=True,manifestPresent=True,dataServiceInstance=101,notReady=[])
        ready=self.apply_identity(ready)
        if self.phase!='menu':ready.update(scene='CentralForest',gameplay=True,anyEvent=False,
            conversation=self.phase in ['tutorial','bucky'],playerPresent=True,playerPath=p.BUCKY_PLAYER,
            playerInstance=71,playerPosition=FIXTURE['playerRespawnData']['lastPosition'],tutorialIntroControllers=1)
        return ready

    def keyboard(self, action=None, position=None, velocity=None):
        self.tick()
        row=admission.keyboard_fixture()
        row.update(frame=str(self.frame),time=str(self.realtime),scene='CentralForest',gameplay='True',
            anyEvent='False',conversation=str(self.phase=='bucky'),movement=str(self.phase!='bucky'),
            dustin='False',glitch='False',lanternTransition='False',sweaterTransition='False',waypoints='False',
            actor=p.BUCKY_PLAYER+'#71',body=p.BUCKY_PLAYER+'#72',
            bodyPosition=','.join(map(str,position or self.position)),bodyVelocity=velocity or '0,0,0')
        if action:
            key,axis={'right':('RightArrow','1,0,0'),'down':('DownArrow','0,-1,0'),'return':('Return','0,0,0')}[action]
            suffix='Submit' if action=='return' else 'Movement'
            for layer in ['native','async','rewired','unity']:
                row[layer+suffix+'Down']=key;row[layer+suffix+'Up']='False'
            row['actionAxes']=row['fullAxis']=axis
            if action=='return':row.update(rewiredAction2Held='True',rewiredAction2Down='True',helperSubmitDown='True',unityReturnDown='True')
        return row

    def sample_file(self):
        (self.run/'keyboard-samples.txt').write_text('\n'.join('keyboard | '+' | '.join(k+'='+v for k,v in r.items()) for r in self.samples)+'\n')

    def command(self, action, deadline=None):
        assert deadline is None or self.now<deadline, 'fixture received expired command deadline'
        self.tick();self.calls.append(action)
        if self.inject=='unknown-command' and action.startswith('select-bucky217 '):
            p.COMMAND_HOLD=action
            raise TimeoutError('Unknown file transport outcome')
        if action=='dump-save-continuation':self.save('save-continuation.json',self.saved())
        elif action=='menu PlayMenu OnClickContinue':self.phase='tutorial'
        elif action=='dump-intro':self.save('intro-state.json',self.state())
        elif action=='dump-bucky':self.save('bucky-interaction.json',self.approach()['interaction'])
        elif action=='dump-tutorial':self.save('tutorial-route.json',self.approach()['interaction'])
        elif action=='dump-notebook':self.save('notebook-route.json',{})
        elif action=='complete-tutorial158':
            row=json.loads(self.last['tutorialCompletionRecord']);row['result']='applied'
            self.save('completion158-receipt.json',row);self.menu158=True
        elif action=='response 153 120 154':self.eid=155
        elif action.startswith('select-tutorial181 '):
            row=json.loads(self.last['tutorial181Record']);row['result']='submitted'
            self.save('selection181-receipt.json',row);self.eid=182
        elif action.startswith('select-bucky217 '):
            row=json.loads(self.last['bucky217Record']);row['result']='submitted'
            self.save('selection217-receipt.json',row);self.eid=194
        elif action.startswith('continue-bound '):
            conv,eid=map(int,action.split()[1:])
            self.save('continue-receipt.json',dict(result='applied',active=True,expectedConversationId=conv,
                expectedEntryId=eid,actualConversationId=conv,actualEntryId=eid))
            if self.inject=='receipt' and conv==141:self.save('continue-receipt.json',dict(result='applied',active=True,expectedConversationId=120,expectedEntryId=eid,actualConversationId=conv,actualEntryId=eid))
            if self.phase=='tutorial' and eid==187:self.phase='approach'
            elif self.phase=='bucky' and eid==212:
                self.end=dict(conversationId=141,entryId=212,dbName='TutorialQuest_BeaverIntroduction',arc='p1',count=1,frame=self.frame,realtime=self.realtime)
                self.phase='cleanup'
            elif self.phase=='tutorial' and eid in p.TUTORIAL181_ROUTE:
                self.eid=p.TUTORIAL181_ROUTE[p.TUTORIAL181_ROUTE.index(eid)+1]
            else:self.eid+=1
        elif action=='dump-bucky-completion':
            self.save('bucky-completion.json',self.apply_identity(graph.completion(self.frame,self.end)))
        elif action=='sample-keyboard-start':self.samples=[]
        elif action in ['sample-keyboard-snapshot','sample-keyboard-stop']:
            if not self.samples:self.samples=[self.keyboard(),self.keyboard()]
            else:self.samples += [self.keyboard(),self.keyboard()]
            if self.inject=='owner-input' and not self.native:self.samples[-1]['nativeSubmitDown']='Space';self.samples[-1]['nativeSubmitUp']='False'
            if self.inject=='release' and self.native:self.samples[-2]['nativeSubmitUp']=self.samples[-1]['nativeSubmitUp']='False'
            self.sample_file()
        else:raise AssertionError('Unexpected mock command: '+action)
        return dict(command=action,transportExitCode=0,acknowledgement='stamp OK '+action,submittedAt=self.now,acknowledgedAt=self.now)

    def inspect(self, argv, **kwargs):
        self.tick()
        if argv[2]=='inspect':return subprocess.CompletedProcess(argv,0,json.dumps(self.target),'')
        assert argv[2].startswith('release-'),argv
        self.recoveries.append(argv)
        return subprocess.CompletedProcess(argv,0,'UP','')

    def popen(self, argv, stdout, stderr, **kwargs):
        self.native.append(argv)
        action=argv[2]
        assert argv[-2:]==['1234','5678']
        assert argv[3]=='100'
        identity=dict(self.target,mode=action)
        stdout.write(json.dumps(identity)+'\npost'+action.title()+'Down pid=1234 window=5678 unixTime=1\n');stdout.flush()
        start=self.position[:]
        if self.inject!='displacement':
            if action=='right':self.position[0]+=.12
            if action=='down':self.position[1]-=.12
        velocity='1.2,0,0' if action=='right' else '0,-1.2,0' if action=='down' else '0,0,0'
        during=self.keyboard(action,position=start,velocity=velocity)
        if self.inject=='ingress':during['helperSubmitDown']='False' if action=='return' else during['helperSubmitDown'];during['unityMovementDown']=''
        self.samples += [during,self.keyboard(),self.keyboard()]
        if action=='return':self.phase='bucky';self.eid=215
        if self.inject!='unknown-native':stdout.write('post'+action.title()+'Up pid=1234 window=5678 unixTime=2\n');stdout.flush()
        world=self
        class Child:
            pid=9876
            returncode=None if world.inject=='unknown-native' else 0
            def poll(self):return self.returncode
            def wait(self,timeout):
                if world.inject=='unknown-native':raise subprocess.TimeoutExpired(argv,timeout)
                return self.returncode
        return Child()


class BuckyHost(unittest.TestCase):
    def run_world(self, world, full=False):
        with patch.object(p,'RUN',world.run),patch.object(p,'COMMAND_HOLD',None), \
                patch.object(p,'command',side_effect=world.command), \
                patch.object(p.time,'monotonic',side_effect=lambda:world.now),patch.object(p.time,'sleep',side_effect=world.sleep), \
                patch.object(p.subprocess,'run',side_effect=world.inspect),patch.object(p.subprocess,'Popen',side_effect=world.popen):
            if full:
                menu=dict(world.saved(),components=['PlayMenu Canvas/PlayMenu'],buttons=['Canvas/PlayMenu/Controls/Continue'])
                p.continue_from_fixture(menu,FIXTURE,p.ContinueObservationBudget(world.now),continue181=True,continue_bucky=True)
            else:
                world.phase='approach';p.ordinary_bucky141()

    def test_whole_host_from_qa43_prefix_181_cleanup_native_movement_submit_217_212(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));self.run_world(w,full=True)
            prefix=json.loads((w.run/'continue-progression.json').read_text())
            self.assertTrue(prefix['subtitleAndResponseEvidence']['actual182Observed'])
            self.assertEqual(len(prefix['actualTerminalFrames']),2)
            complete=json.loads((w.run/'bucky-completion-result.json').read_text())
            self.assertEqual(complete['observedRouteSubtitles'],p.BUCKY141_ROUTE)
            self.assertTrue(complete['actual194Observed']);self.assertEqual(complete['real212LineEnd'],w.end)
            self.assertEqual(len(complete['cleanupFrames']),2)
            self.assertEqual(complete['completion']['parsed']['counts'],dict(zip(p.BUCKY141_COUNTS,[1,0,0,0])))
            self.assertEqual([a[2] for a in w.native].count('return'),1)
            self.assertEqual(len([c for c in w.calls if c.startswith('select-bucky217 ')]),1)
            self.assertEqual(w.calls.count('menu PlayMenu OnClickContinue'),1)
            self.assertFalse(w.recoveries)
            self.assertFalse(any(c.startswith('capture ') for c in w.calls))
            self.assertTrue(all(a[2] in ['right','down','return'] for a in w.native))

    def test_unknown_native_keeps_helper_and_never_replays_or_recovers(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));w.inject='unknown-native'
            with self.assertRaisesRegex(TimeoutError,'outcome unknown'):self.run_world(w)
            self.assertEqual(len(w.native),1);self.assertFalse(w.recoveries)
            report=json.loads((w.run/'bucky-move-00-pulse.json').read_text())
            self.assertTrue(report['taskDownReceipt']);self.assertIsNone(report['exitCode'])
            self.assertEqual(report['unresolvedNative'],'native-bucky-move-00')
            self.assertNotIn('sample-keyboard-stop',w.calls)

    def test_owner_input_rejects_before_down_without_release(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));w.inject='owner-input'
            with self.assertRaisesRegex(AssertionError,'non-idle before DOWN'):self.run_world(w)
            self.assertFalse(w.native);self.assertFalse(w.recoveries)

    def test_ingress_displacement_authority_fail_before_next_down(self):
        for inject,reason,count in [('ingress','four-layer ingress',1),('displacement','unchanged/unexpected displacement',1),('authority','unexpected authority',0)]:
            with self.subTest(inject=inject),tempfile.TemporaryDirectory() as tmp:
                w=World(Path(tmp));w.inject=inject
                with self.assertRaisesRegex(AssertionError,reason):self.run_world(w)
                self.assertEqual(len(w.native),count)

    def test_unknown_selection_command_never_replays(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));w.inject='unknown-command'
            with self.assertRaisesRegex(TimeoutError,'Unknown file transport'):self.run_world(w)
            self.assertEqual(len([c for c in w.calls if c.startswith('select-bucky217 ')]),1)
            self.assertEqual([a[2] for a in w.native].count('return'),1)

    def test_wrong_story_and_continue_receipt_stop_at_source_boundary(self):
        for inject,reason in [('source','rendered subtitle'),('receipt','receipt does not match')]:
            with self.subTest(inject=inject),tempfile.TemporaryDirectory() as tmp:
                w=World(Path(tmp));w.inject=inject
                with self.assertRaisesRegex(AssertionError,reason):self.run_world(w)
                self.assertEqual([a[2] for a in w.native].count('return'),1)
                self.assertFalse((w.run/'bucky-completion-result.json').exists())

    def test_fixed_deadlines_no_progress_renewal_from_polling(self):
        for name,seconds in [('bucky-movement',120),('bucky-submit',15)]:
            b=p.BuckyActionBudget(name,10.,seconds);b.check(11.)
            with self.assertRaisesRegex(AssertionError,'fixed deadline'):b.check(11.+seconds)
            self.assertEqual(b.progress_at,10.)
        b=p.BuckyActionBudget('bucky-movement',10.,120)
        with self.assertRaisesRegex(AssertionError,'unchanged progress'):b.check(31.)

    def test_link_pin_rejection_before_any_action_and_option_dependencies(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));plan=copy.deepcopy(graph.PLAN);plan['entries'][3]['outgoingLinks']=[]
            w.save('bucky141-plan.json',plan)
            with self.assertRaisesRegex(AssertionError,'source link'):self.run_world(w)
            self.assertFalse(w.calls);self.assertFalse(w.native)
        with self.assertRaisesRegex(AssertionError,'full original181'):p.launch_options(['/tmp/run','--bucky141'])
        self.assertTrue(p.launch_options(['/tmp/run','--continue-fixture','--tutorial181','--bucky141']).bucky141)

    def test_failed_release_uses_only_the_receipted_task_key(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));w.inject='release'
            with self.assertRaisesRegex(AssertionError,'release/zero axes'):self.run_world(w)
            self.assertEqual(len(w.native),1);self.assertEqual(len(w.recoveries),1)
            self.assertEqual(w.recoveries[0][2:],['release-right','1234','5678'])

    def test_stale_frame_state_and_motion_fail_before_native_delivery(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));w.phase='approach'
            with patch.object(p,'RUN',w.run):
                packet=w.approach();p.bucky_approach_guard(packet)
                for field,value,reason in [('frame',packet['state']['frame']+121,'stale sample frame'),
                        ('realtime',packet['state']['realtime']+3,'stale sample time'),
                        ('conversationActive',True,'unexpected story'),('dataServicePresent',False,'Inconsistent absent singleton')]:
                    bad=copy.deepcopy(packet);bad['state'][field]=value
                    with self.subTest(field=field),self.assertRaisesRegex(AssertionError,reason):p.bucky_approach_guard(bad)
                for old,new,reason in [('swim=null','swim=active','movement readiness'),
                        ('currentSpeed=1.2,1.2,0','currentSpeed=2,2,0','walking speed'),
                        ('authorityId=991','authorityId=0','Scarlett authority')]:
                    bad=copy.deepcopy(packet);bad['interaction']['diagnostics']=[r.replace(old,new) for r in bad['interaction']['diagnostics']]
                    with self.subTest(old=old),self.assertRaisesRegex(AssertionError,reason):p.bucky_approach_guard(bad)
            self.assertFalse(w.native)

    def test_submit_requires_actual_action2_and_inputhelper_same_frame(self):
        with tempfile.TemporaryDirectory() as tmp:
            w=World(Path(tmp));w.phase='approach';w.position=[7.8,6.6,0.]
            with patch.object(p,'RUN',w.run):
                result=p.bucky_approach_guard(w.approach())
            rows=[w.keyboard(),w.keyboard('return'),w.keyboard(),w.keyboard()]
            p.bucky_input_proof(rows,result,'return')
            for field,value,reason in [('helperSubmitDown','False','matching-frame'),
                    ('rewiredAction2Down','False','matching-frame'),('rewiredSubmitDown','','four-layer'),
                    ('body',p.BUCKY_PLAYER+'#999','identity changed'),('actionAxes','1,0,0','unexpected axes')]:
                bad=copy.deepcopy(rows);bad[1][field]=value
                with self.subTest(field=field),self.assertRaisesRegex(AssertionError,reason):p.bucky_input_proof(bad,result,'return')
            bad=copy.deepcopy(rows);bad[1]['frame']=bad[0]['frame']
            with self.assertRaisesRegex(AssertionError,'stale keyboard'):p.bucky_input_proof(bad,result,'return')


if __name__=='__main__':unittest.main()
