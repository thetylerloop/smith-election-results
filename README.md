# smith-election-results

Analysis of Smith County election results data.

*Not all contents of these repo were validated for publication.* All results should be treated as experimental.

## Files

* `analyze.R`: Voter file analysis script.
* `election_results_schema.csv`: Fixed-width format schema for in2csv.
* `results.csv`: Parsed results.

*Note:* raw data files are not included due to size.

## Usage

Create CSV results data:

```
in2csv -f fixed -s election_results_schema.csv data/16GSMITH.ASC > results.csv
```
