Files:

* `16GSMITH.ASC`: 2016 general election results provided by Smith County Elections Office (in fixed-width state reporting format)
* `election_results_schema.csv`: Fixed-width format schema for in2csv.
* `results.csv`: Parsed results.

Parsed command:

```
in2csv -f fixed -s election_results_schema.csv 16GSMITH.ASC > results.csv
```
