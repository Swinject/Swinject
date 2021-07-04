#!/bin/bash

set -eo pipefail

xcodebuild "${{ matrix.ACTION }}" -project "${{ matrix.PROJECT }}" -scheme "${{ matrix.SCHEME }}" -sdk "${{ matrix.SDK }}" -destination "${{ matrix.DEST }}" -configuration Release ENABLE_TESTABILITY=YES | xcpretty