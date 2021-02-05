#!/bin/bash

ANALYZER=$PWD"/tools/report_analyzer.py"
OUT_DIR=$PWD"/out/report/"
COMPARE_REPORT=$OUT_DIR"/report.csv"
BASE_REPORT=$OUT_DIR"/base_report.csv"
CHANGES_SUMMARY=$OUT_DIR"/"$JOB_NAME"_changes_summary.json"

set -x
set -e

source "$HOME/miniconda/etc/profile.d/conda.sh"
hash -r
conda activate sv-test-env
hash -r

# Get base report from sv-tests master run
wget https://symbiflow.github.io/sv-tests-results/report.csv -O $BASE_REPORT

python $ANALYZER $COMPARE_REPORT $BASE_REPORT -o $CHANGES_SUMMARY

mv $COMPARE_REPORT $OUT_DIR"/"$JOB_NAME"_report.csv"

set +e
set +x
