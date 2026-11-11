# prepare-code

## 1. What it does
This skill takes the approved data request and turns it into reusable R code for loading and merging the selected ALIFE data files. It selects the closest template, fills in the agreed years and variables, and writes code that is ready for a person to review before any analysis begins.

The purpose is not analysis. The purpose is preparation: create a clean, reviewable data extract and stop before any modelling or interpretation begins.

## 2. Technical or non-technical
This is technical. It writes or reads R code, loads a data library, and works with CSV files and joins. It also involves a person review step, but the actual work is code-based and file-based.

The R term “R” appears here as a programming language used for data work, not as the topic of the workshop itself.

## 3. Steps
1. Receive the approved data brief
   - Input: the final needs brief and the variable map from the previous skills.
   - What the skill does: checks that the question, years, variables, and merge logic are approved and complete enough to code.
   - Output: a final specification for code building.

2. Pick the right template from the small R library
   - Input: the final data specification.
   - What the skill does: selects the template that matches the data pattern: one year versus several years, one dataset versus multiple joined datasets, or a direct person-level file versus a relationship file with extra joins.
   - Output: the chosen template and any custom sections that need to be filled.

3. Fill in the file and variable list
   - Input: the chosen template and the approved variable map.
   - What the skill does: writes the `Get.Years` and `Get.Vars` sections, adds the selected file names, and ensures the variable names match the approved ALIFE names.
   - Output: a working data-definition section for the chosen years and variables.

4. Build the load-and-merge routine
   - Input: the approved files and variable list.
   - What the skill does: creates a loop that reads each year of data, renames the variables to year-specific names, and merges the files on the person-level ID, typically `alife_id_001`.
   - Output: a merged dataset prepared for review.

5. Run the sense-checks and stop before analysis
   - Input: the merged object.
   - What the skill does: checks for obvious errors such as mismatched row counts, too many unmatched IDs, or a merge that creates suspicious gaps. It does not analyse or model the outcome; it simply verifies that the data shape is credible.
   - Output: either a clean review-ready dataset or a list of issues to fix before the analyst sees it.

6. Hand off for human review
   - Input: the final prepared data and code.
   - What the skill does: leaves the load-and-merge file in a ready-to-review state and marks any assumptions or warnings for the analyst.
   - Output: a reviewed extract that is ready for policy or research work only after a human checks it.

## 4. Inputs and handoff
This skill begins only when the previous skills have produced:
- the final question and population;
- the chosen years;
- the variable list;
- the exact files or tables to read;
- the approved merge key and join plan.

The handoff after the code is generated is a review-ready script, not a model or an analysis result. The person checks whether the load and merge are sensible before doing any real work with the data.

## 5. If-then options
There are four common branches.

1. Single-year prep: if only one year is required, the code writes one read-and-rename block rather than a multi-year loop.
2. Multi-year comparison: if the request spans more than one year, the code loops over the year list and creates year-specific variable names before the merge.
3. Direct individual-file merge: if the variables are already in the relevant individual-level files, the merge uses the person-level ID and stays straightforward.
4. Related-table merge: if the concept sits in a payment or relationship table, the code adds the extra file and a join through the correct related ID or person ID before the review step.

## 6. Stop points
The skill must pause when:
- the merge key is missing or inconsistent;
- the row count after merging is implausible;
- the chosen template does not match the actual file structure;
- the selected variables do not line up with the approved list;
- the analyst needs to decide whether missing values should stay missing or be treated as zero.

At each stop point, the person checks whether the code behaves as expected and whether the returned data shape makes sense before the script is accepted.

## 7. Reference files
This skill uses the project’s existing code library and reference data.

Reference files used in the workshop:
- `ExampleDataOrg.R` — the worked template for reading and merging ALIFE-style data by year and person ID.
- `SynthData/ALife_Individuals/` — the synthetic year-by-year CSV files that the code is expected to read.
- `specs/references/Dictionary.xlsx` — the variable dictionary used to confirm the final variable names before writing code.

## 8. Hooks and other special conditions
This skill should include at least one deterministic validation hook because the real risk is a bad merge that passes a casual review.

Hook spec 1:
- When: after the load-and-merge code runs on the synthetic data
- Reads: the merged dataset and the list of expected IDs
- Rule: the row count equals the number of unique IDs across the selected years, allowing for the agreed join structure and the known data conventions
- Pass: nothing happens
- Fail: warn and return the expected and actual counts so the analyst can confirm whether the merge is sensible

Hook spec 2:
- When: after the R file is saved
- Reads: the script and `Dictionary.xlsx`
- Rule: every variable name in the code appears in the dictionary's variable column
- Pass: nothing happens
- Fail: block and return the missing variable names

These are deterministic and do not require a human to decide on a fuzzy judgement.

## 9. What good looks like
A good result is a review-ready load-and-merge script that loads the correct files, renames variables consistently, and merges the data without silent surprises.

Example bracket creep request:
- Request: create a two-year load-and-merge script for bracket creep comparison using the same people in 2015 and 2025.
- Acceptable answer: a script that reads the two year files, renames the chosen variables with year suffixes, merges on `alife_id_001`, and produces a table with one row per person and one set of columns per year, ready for a human to inspect before any tax analysis begins.

## 10. Watch out for
- Merging on the wrong ID or on an ID that is not stable across years.
- Forgetting to rename variables before combining multiple years, which hides which year each variable came from.
- Reading the wrong files or missing year-specific naming conventions.
- Allowing unmatched rows to disappear without checking what was lost.
- Writing code that looks plausible but silently creates a merge with a different population from the one the analyst asked for.

Justin catches these by deliberately checking the row count, the missing IDs, and whether the final data still represents the right people after the merge.

## 11. Core or personal
Core steps:
- select the correct template;
- write the variable and year list;
- create the load-and-merge loop;
- run the validation checks;
- stop before analysis.

Personal style:
- Justin keeps a strong review step that looks for missing IDs and suspicious row counts, rather than trusting the merge to be correct because the code ran.
- He also prefers a template-based approach so that the same structure is used repeatedly, but with the exact variable list changed for each request.

## Decisions
- Decision: the skill stops before analysis and before modelling. Reason: the goal is only to prepare and validate a clean extract for human review.
- Decision: use a deterministic hook on row counts and variable names. Reason: these checks are objective and reliably catch common coding errors.
- Decision: build from a small template library rather than one-off code for every request. Reason: the workshop emphasizes repeatable skill-building and a consistent process.

## Unknowns
- [unknown] the exact final R library structure or template names if Justin's broader project library contains more templates than the example code shows.
- [unknown] any final workshop-specific tax treatment rules beyond the synthetic sample data and the bracket creep example.
- [unknown] the exact full variable list for the final bracket creep demonstration if the analyst changes the example after the initial brief is drafted.
