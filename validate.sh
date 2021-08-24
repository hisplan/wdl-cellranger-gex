#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    CellRangerGex.wdl \
    --inputs ./configs/template.inputs.json
