# find-data

## 1. What it does
This skill turns a ready-made needs brief into a concrete ALIFE dataset and variable map. It reads the dictionary and the synthetic file naming conventions to find the actual dataset names, variable names, and join keys needed for a clean load.

It is the translation step between plain English and the data files: the analyst says what they want, and this skill says which ALIFE tables and columns are the best fit.

## 2. Technical or non-technical
This is a technical skill because it reads a data dictionary and inspects the file structure and variable names. It also requires judgement for choosing the best table or join, but most of the work is a structured lookup rather than a free-form conversation.

## 3. Steps
1. Start from the needs brief
   - Input: the output of define-need, including the question, years, target population, variables, and assumptions.
   - What the skill does: checks that the brief is complete enough to begin, including which years and which variables matter most.
   - Output: a verified request list ready for the dictionary lookup.

2. Read the ALIFE dictionary and data layout
   - Input: the needs brief and the ALIFE dictionary.
   - What the skill does: looks up each concept in the dictionary, identifies the relevant table or tables, and confirms the names of the candidate variables and their labels.
   - Output: a list of likely dataset names and candidate variable names.

3. Match each requested concept to one or more real variables
   - Input: the variable list from the brief.
   - What the skill does: checks whether each requested concept is a person-level variable, a payment variable, an income variable, or a relationship variable. It maps each concept to the closest ALIFE variable(s) and notes any gap or ambiguity.
   - Output: a final candidate mapping for each concept.

4. Decide whether a direct lookup or a join is needed
   - Input: the candidate data tables and variables.
   - What the skill does: determines whether the variable lives in the individual table, a separate year-specific table, or a relationship table that must be joined through an ID field such as `alife_id_001` or a cross-table relationship ID.
   - Output: a join plan and a shortlist of required files.

5. Check the synthetic file convention
   - Input: the chosen tables and years.
   - What the skill does: confirms the file naming pattern used in the synthetic dataset, such as year-specific CSV files under ALIFE folders, and makes sure the selected variables are available in the actual data files for the chosen years.
   - Output: a list of exact files to read and the years covered.

6. Write the handoff for prepare-code
   - Input: the final mapping, file list, and join plan.
   - What the skill does: converts the approved mapping into a code-ready summary: the exact years, exact variable names, file names, and the key used to merge tables.
   - Output: a file-and-variable map that the prepare-code skill can turn into R code.

## 4. Inputs and handoff
The skill begins once define-need has produced a question, years, population, and variable list.

The inputs are:
- the agreed brief from define-need;
- the ALIFE dictionary;
- the synthetic data file naming pattern;
- any notes on whether the needed concept is person-level, relationship-level, or income-level.

The handoff to prepare-code is a code-ready specification with:
- exact file names or file groups;
- exact variable names; 
- exact year range;
- the merge key or join logic;
- any variables that were rejected or are still ambiguous.

## 5. If-then options
There are four main branches.

1. Direct person-level match: if the concept is already in the individual file, the skill maps it directly to the relevant column and keeps the join simple.
2. Related table required: if the concept sits in a separate table, the skill adds the related table and a join through the correct ID field.
3. Multi-year comparison: if the request spans several years, the skill maps each year-specific file and variable with a year suffix or a looped naming convention.
4. No direct match: if no exact match exists, the skill stops and asks the analyst to re-scope the variable or accept a proxy variable that fits the question.

## 6. Stop points
The skill must pause when:
- the variable cannot be found in the dictionary;
- there are multiple plausible tables and no clear reason to choose one;
- the join key is unclear or not present in both tables;
- the request depends on a variable not allowed in the synthetic data or not yet defined;
- the same concept has different definitions across tables and the analyst must choose which one matches the policy question.

The human checks the mapping and approves the final variable selection before code-writing begins.

## 7. Reference files
This skill reads the ALIFE dictionary and inspects the synthetic data folder layout.

Reference files used in the workshop:
- `specs/references/Dictionary.xlsx` — defines the ALIFE variables, labels, and table groupings.
- `SynthData/ALife_Individuals/` — shows the actual synthetic file naming patterns and year-by-year file structure used to map the request to real files.

## 8. Hooks and other special conditions
The key hook for this skill is a deterministic validation check: after the variable map is built, every requested variable must appear in the dictionary or be explicitly marked as a still-open gap.

Hook spec:
- When: after the skill completes a variable-to-dataset mapping
- Reads: the draft variable map and `Dictionary.xlsx`
- Rule: every requested variable either matches a dictionary entry or is written as a known gap and flagged for analyst review
- Pass: nothing happens
- Fail: stop and return the variables that cannot be mapped

This is a good fit for a hook because it is deterministic and does not require human judgement.

## 9. What good looks like
A good result is a clean variable map that can be given directly to R code without extra discovery work.

Example bracket creep request:
- Request: compare the same people across 2015 and 2025 using income and tax-related variables.
- Acceptable answer: a mapping such as “use the individual ALIFE file for person-level identifiers and income variables; map all year-specific variables to the matching year files; keep `alife_id_001` as the key; add any tax or payment variables only after confirming the table and column names in the dictionary.”

## 10. Watch out for
- Matching a concept to a variable by label alone without checking the exact ALIFE name.
- Choosing a table that exists but is not the correct unit of analysis.
- Forgetting that some ALIFE files are year-specific and need a year loop or suffix.
- Ignoring the need to keep the ID field stable across years when the request is a cross-year comparison.
- Treating a dictionary label as a final answer without checking the table and column structure.

Justin catches these by checking whether the mapping makes sense for the unit of analysis and whether the same ID can be used across the years being compared.

## 11. Core or personal
Core steps:
- translate the question into variables;
- find the correct ALIFE table or variable;
- decide when a join is needed;
- confirm the merge key and file naming pattern;
- hand off a code-ready mapping.

Personal style:
- Justin prefers to keep the same person-level key throughout the dataset and to test whether a join makes sense by checking whether the expected IDs are missing after the join.
- He also treats some data sources as “related tables” rather than direct inputs, especially if a variable is about payments or relationships rather than the person themselves.

## Decisions
- Decision: keep the dictionary lookup as the main verification step, not the code-writing step. Reason: the data mapping has to be right before code can be generated.
- Decision: treat the ALIFE dictionary as the ground truth for names and table membership. Reason: the synthetic files are examples of the real naming system, but the dictionary is the place where the variable definitions are stated.
- Decision: require a stop point when the mapping is ambiguous. Reason: a wrong join or wrong table would produce a misleading data extract before the analyst even sees it.

## Unknowns
- [unknown] the exact final file list for any specific workshop case if the analyst changes the variables after the brief is drafted.
- [unknown] which relationship table should be preferred when several tables contain similar concepts and the analyst has not clarified the policy question.
- [unknown] any exact tax-threshold rules or imputation choices that are not covered in the available project materials.
