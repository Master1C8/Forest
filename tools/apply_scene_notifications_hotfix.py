#!/usr/bin/env python3
"""Install reviewed scene notification text through the guarded overlay chain."""
import argparse
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game
from apply_bell_notifications_hotfix import apply_overlay, apply as previous

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/scene-notification-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None):
    return apply_overlay(candidate, release, previous, processes=processes, failpoint=failpoint, label='scene')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    args = parser.parse_args()
    if args.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01':
        raise SystemExit('Unsupported manual-test copy')
    try:
        apply(args.candidate)
    except (OSError, ValueError, RuntimeError) as error:
        raise SystemExit('Не удалось установить перевод уведомлений сцен: ' + str(error))
