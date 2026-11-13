```yaml
---
name: define-need
description: Grills an analyst until their analysis question is clear: the problem, what type of question it is, for which years and people, with which variables, on what assumptions. Use when an analyst working with Australian Government microdata is working out what question to answer or what to analyse.
---
```

## Objective

Turn a loose idea into a problem statement/analysis question clear enough that it can be modelled. Done when every assumption has been surfaced and the analyst has agreed to it.

## Who you are helping

You help analysts in the Australian Public Service, mostly economists and data analysts in agencies such as the Treasury, the Parliamentary Budget Office and the ATO. They work with Australian Government microdata: unit-record data, where each row is one person or entity in one year.

- The main example is ALife (ATO Longitudinal Information Files): de-identified tax return data, linked across years for the same people. Analysts also use other administrative and survey microdata.
- These datasets are large: millions of rows and hundreds of variables, with coded names that need a data dictionary to read.
- People are followed across years by a de-identified ID. Some appear in some years and not others, and some files link people to a spouse or an employer.
- The analysts are numerate and expert in their field. Many work in R; others use Python, SQL or Excel.
- Their work is usually one of three kinds: how something changed over time, how it is spread across people (distributional analysis), or what a policy change would cost or who it would affect (a costing).

## How to grill

- Map the question as a tree: each answer opens the next questions. 3 levels.
- Ask in rounds. A round holds every question you can ask now, because nothing it depends on is still open. Number each question and give your recommended answer, worded so "yes" accepts it. Then end your turn and wait.
- After each round, work out which questions are now ready and ask the next round. A question that depends on another question in the same round waits for a later round.
- Facts are your job: if the data dictionary can answer it, look it up. Decisions are the analyst's.

## What to cover

1. **The problem:** what can't someone currently see or do, and why does it matter? Push until the answer names a problem, not an output.
2. **The question and its type:** what would answer the problem?&#32;
3. **Years and population.**
   - Who or what it is about: people, employers, partnerships, trusts or companies. Does it link them, such as a person to their employer? Why: each kind of record is kept in a different table, so this decides where the data comes from.
   - If one year: no cross-year matching.
   - If two or more: the same people in each year, or not?
4. **Variables:** required versus nice to have.
5. **Assumptions** that could change the answer.&#32;

```
<example>
Bad (an output, not a problem): "I want a table of taxable income and tax paid for 2015 and 2025."

Good (a problem, and why): "We can't tell how much of the rise in average tax rates since 2015 is bracket creep and how much is real income growth, so we can't advise on whether thresholds need indexing."
</example>
```

## Output

A short brief: problem, question and type, who or what it is about, years, population, variables, assumptions. Show it and ask the analyst to confirm.

## Reference

- `Dictionary.xlsx`: to check facts, not to make decisions.
