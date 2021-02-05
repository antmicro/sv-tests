#!/bin/bash

ANALYZER=$PWD"/tools/report_analyzer.py"
OUT_DIR=$PWD"/out/report/"
COMPARE_REPORT=$OUT_DIR"/tests_report.csv"
BASE_REPORT=$OUT_DIR"/base_report.csv"
CHANGES_SUMMARY_JSON=$OUT_DIR"/tests_summary.json"
CHANGES_SUMMARY_MD=$OUT_DIR"/tests_summary.md"

set -x
set -e

source "$HOME/miniconda/etc/profile.d/conda.sh"
hash -r
conda activate sv-test-env
hash -r

# Get base report from sv-tests master run
wget https://symbiflow.github.io/sv-tests-results/report.csv -O $BASE_REPORT

# Delete headers from all report.csv
for file in $(find ./out/changes_summary_* -name "*.csv" -print); do
	sed -i.backup 1,1d $file
done

# concatenate test reports
cat $(find ./out/changes_summary_* -name "*.csv" -print) >> $COMPARE_REPORT

# Insert header at the first line of concatenated report
sed -i 1i\ $(cat $(find ./out/changes_summary_* -name "*.csv.backup" -print | head -1) | head -1) $COMPARE_REPORT

python $ANALYZER $COMPARE_REPORT $BASE_REPORT -o $CHANGES_SUMMARY_JSON -t $CHANGES_SUMMARY_MD

set +e
set +x

