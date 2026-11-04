"""Update only coordinator-owned delivery sections; preserve unrelated dirty roots."""
from pathlib import Path
import json,subprocess,copy
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'localization/completion/launcher-all30-20261104-01';index=C/'root-index';index.mkdir(exist_ok=False)
mac=json.loads((R/'MacOS/build-receipt.json').read_bytes());mv=json.loads((R/'MacOS/validation.json').read_bytes());win=json.loads((R/'Windows/build-receipt.json').read_bytes());wv=json.loads((R/'Windows/validation.json').read_bytes())
header='''# Language launchers

The macOS launcher and Windows installer now include all 30 translations plus
original English. Hindi, Swahili and Ukrainian have complete independent wording
review, exact correction closure and both platform resource builds. Russian keeps
the owner's accepted baseline. The upgraded macOS app was opened and all 31 menu
options were verified through native accessibility; Russian remains selected.

Version 1.1.0 passes 118 actual-resource macOS assertions, 141 synthetic macOS
assertions and 83 actual Windows-payload assertions on the macOS host. Switching
and original-English restoration preserve test saves/settings. No new target game
was launched. In-game font/layout acceptance, including Hindi Devanagari shaping,
remains separate; whole-project archival remains pending.

See [macOS instructions](MacOS/README.md), [Windows instructions](Windows/README.md)
and [the all-30 completion record](localization/completion/launcher-all30-20261104-01/delivery.json).

'''
for data,output in [( (R/'README.md').read_text(),R/'README.md'),(subprocess.check_output(['git','show','HEAD:README.md'],cwd=R,text=True),index/'README.md')]:
 assert data.startswith('# macOS language launcher\n');marker='# Six new locale tasks\n';assert data.count(marker)==1;output.write_text(header+data[data.index(marker):])
completion=dict(status='all30-editorial-and-both-app-delivery-verified',locales=['hi','sw','uk'],translationLocales=30,totalOptions=31,delivery='localization/completion/launcher-all30-20261104-01/delivery.json',runtime='No new target game launch; target font/layout/Devanagari acceptance remains unrun',projectArchival='pending-unfinished-project-and-owner-delivery-acceptance')
for data,output in [(json.loads((R/'CHECKPOINT.json').read_bytes()),R/'CHECKPOINT.json'),(json.loads(subprocess.check_output(['git','show','HEAD:CHECKPOINT.json'],cwd=R)),index/'CHECKPOINT.json')]:
 m=data['macosInstaller'];m.update(status='built-isolated-and-launcherUI-verified',version='1.1.0',artifact=mac['artifact'],artifactSha256=mac['sha256'],artifactBytes=mac['bytes'],translationLocales=30,excludedLocales=[],nativeResourceLocalesPassed=30,syntheticAssertions=141,actualResourceAssertions=118,actualResourceTestSequence=['hi','sw','uk','ru','en'],launcherUI='actual-all31-options-and-footer-verified',gameLaunch='no-new-target-launch',newNativeStreamingReadbacks=3,retainedNativeStreamingReadbacks=27)
 w=data['windowsInstaller'];w.update(status='built-and-isolated-verified',version='1.1.0',artifact=win['artifact'],artifactSha256=win['sha256'],artifactBytes=win['bytes'],translationLocales=30,excludedLocales=[],normalCompilerLocalesPassed=30,nativeBundleRoundtripsPassed=30,actualResourceTestLocales=['hi','ru','sw','uk'],actualResourceAssertions=83,freshNormalCompilerBuilds=3,retainedPublishedCompilerOutputs=27)
 data['launcherAll30Completion20261104']=completion;output.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
print('Working roots preserve unrelated content; index variants contain only delivery updates over HEAD')
