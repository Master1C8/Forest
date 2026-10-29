#!/usr/bin/env python3
"""Install Dates text and unified bell title layout only while the game is absent."""
import argparse
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game
from apply_bell_notifications_hotfix import apply_overlay
from apply_scene_notifications_hotfix import apply as previous

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/dates-titleflow-hotfix'

def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None):
    return apply_overlay(candidate, release, previous, processes=processes, failpoint=failpoint, label='dates-titleflow')

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--candidate', type=Path, required=True)
    a = p.parse_args()
    if a.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01':
        raise SystemExit('Unsupported manual-test copy')
    try:
        apply(a.candidate)
    except (OSError, ValueError, RuntimeError) as error:
        raise SystemExit('Не удалось установить перевод свиданий и заголовков: ' + str(error))
