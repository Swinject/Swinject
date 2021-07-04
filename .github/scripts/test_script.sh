#!/bin/bash

set -eo pipefail

xcodebuild "$ACTION" -project "$PROJECT" -scheme "$SCHEME" -sdk "$SDK" -destination "$DEST" -configuration Release ENABLE_TESTABILITY=YES | xcpretty