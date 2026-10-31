#!/usr/bin/env python3
"""Single entry point for data-driven Forest localization builds."""
import json
import sys
from forest_localization.core import main

if __name__ == '__main__':
    try:
        main()
    except ValueError as error:
        print(json.dumps(dict(passed=False, error=str(error))), file=sys.stderr)
        sys.exit(2)
