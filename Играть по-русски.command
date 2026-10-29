#!/bin/zsh
set -euo pipefail

forest_project="${0:A:h}"
forest_game="$forest_project/localization/previews/ru-20261029-narrative42-01/game"
forest_wine="/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine"
forest_bottle="/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam"

if [[ ! -x "$forest_wine" || ! -d "$forest_bottle" ]]; then
  print -u2 "Не найдена среда CrossOver. Подключи диск KINGSTONMAC и открой CrossOver."
  exit 1
fi
if [[ ! -f "$forest_game/The Forest of Love.exe" ]]; then
  print -u2 "Не найдены файлы русской сборки. Запускай этот файл из папки Forest."
  exit 1
fi

/usr/bin/python3 -B "$forest_project/tools/apply_lantern_hotfix.py" \
  --candidate "$forest_project/localization/previews/ru-20261029-narrative42-01"

forest_stamp="$(/bin/date +%Y%m%d-%H%M%S)"
forest_logs="$forest_project/dist/Forest-Russian-Test-20261029/logs/$forest_stamp-$$"
/bin/mkdir -p "$forest_logs"
cd "$forest_game"
print "Запускаю русскую тестовую сборку…"
exec "$forest_wine" --bottle "$forest_bottle" --no-update \
  "$forest_game/The Forest of Love.exe" \
  -screen-fullscreen 0 -screen-width 1280 -screen-height 720 \
  -logFile "$forest_logs/Player.log"
