"""Exact native Wine identity, including this workstation's drive mappings."""
import argparse
import json
from pathlib import Path
import subprocess


def variants(run):
    exe = str(Path(run).resolve() / 'game/The Forest of Love.exe')
    return [exe, 'Z:' + exe.replace('/', '\\'), 'Y:' + exe.replace('/Users/antonkrutov', '', 1).replace('/', '\\')]


def actual_command(command, run):
    return any(command == prefix or command.startswith(prefix + ' ')
               for value in variants(run) for prefix in (value, '"' + value + '"'))


def observations(run):
    result = []
    for line in subprocess.check_output(['ps', '-axo', 'pid=,ppid=,command='], text=True).splitlines():
        fields = line.strip().split(None, 2)
        if len(fields) != 3 or not any(value in fields[2] for value in variants(run)):
            continue
        result.append(dict(pid=int(fields[0]), ppid=int(fields[1]), command=fields[2], nativeGame=actual_command(fields[2], run)))
    return result


def ps_identity(pid):
    result = subprocess.run(['ps', '-p', str(pid), '-o', 'lstart=', '-o', 'command='], capture_output=True, text=True)
    return result.stdout.strip() if result.returncode == 0 else None


def owned(run, *, allow_absent=False):
    run = Path(run).resolve(); identity = json.loads((run / 'task-process.json').read_text())
    assert isinstance(identity['pid'], int) and identity['pid'] > 1
    assert identity['executable'] == str(run / 'game/The Forest of Love.exe')
    observed = ps_identity(identity['pid'])
    if observed is None:
        assert allow_absent, 'task-process-absent'
        return []
    command = subprocess.check_output(['ps', '-p', str(identity['pid']), '-o', 'command='], text=True).strip()
    assert observed == identity['psIdentity'] and actual_command(command, run), 'task-pid-reused-or-command-changed'
    return [observed]


def no_game_process(run):
    assert not observations(run), 'task-game-process-still-active'


def adopt(run):
    run = Path(run).resolve(); assert not (run / 'task-process.json').exists()
    startup = json.loads((run / 'startup-state.json').read_text())
    assert startup['status'] == 'ready' and startup['readinessFileVerified']
    all_rows = observations(run); games = [r for r in all_rows if r['nativeGame']]
    assert len(games) == 1, ('reconcile-native-game-identity', all_rows)
    pid = games[0]['pid']; identity = ps_identity(pid); assert identity
    (run / 'task-process.json').write_text(json.dumps(dict(pid=pid, executable=str(run / 'game/The Forest of Love.exe'), psIdentity=identity), indent=2) + '\n')
    owned(run)
    (run / 'process-adoption.json').write_text(json.dumps(dict(status='adopted-existing-native-game', observations=all_rows,
        actualPid=pid, processRelaunched=False, boundary='Native command prefix, canonical drive mapping and full ps start/command identity; wrapper excluded'), indent=2) + '\n')
    print(json.dumps(dict(status='adopted-existing-native-game', actualPid=pid)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__); parser.add_argument('--run', type=Path, required=True)
    adopt(parser.parse_args().run)
