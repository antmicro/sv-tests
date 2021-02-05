#!/bin/bash

ANALYZER=$PWD"/tools/report_analyzer.py"
OUT_DIR=$PWD"/out/report/"
COMPARE_REPORT=$OUT_DIR"/report.csv"
BASE_REPORT=$OUT_DIR"/base_report.csv"
CHANGES_SUMMARY=$OUT_DIR"/"$JOB_NAME"_changes_summary.json"

set -x
set -e

# Get a conda environment
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
source "$HOME/miniconda/etc/profile.d/conda.sh"
hash -r
conda config --set always_yes yes --set changeps1 no

conda env create --file conf/environment.yml
conda activate sv-test-env
hash -r
conda info -a

# Get base report from sv-tests master run
wget https://symbiflow.github.io/sv-tests-results/report.csv -O $BASE_REPORT

python $ANALYZER $COMPARE_REPORT $BASE_REPORT -o $CHANGES_SUMMARY

mv $COMPARE_REPORT $OUT_DIR"/"$JOB_NAME"_report.csv"

set +e
set +x
