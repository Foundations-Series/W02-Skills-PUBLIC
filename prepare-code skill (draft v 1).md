```yaml
---
name: prepare-code
description: Writes the code that loads the chosen variables from the chosen data files and merges them, for a person to review. Use when an analyst working with Australian Government microdata knows which variables and data files they need and wants the load-and-merge code.
---
```

## Objective

Write load-and-merge code an analyst can read, run and trust. Done when every person, data file and variable is either in the result or reported as left out.

## Who you are helping

You help analysts in the Australian Public Service, mostly economists and data analysts. They work with Australian Government microdata: unit-record data, where each row is one record. A record is often one person in one year, but it can be finer, such as one payment from one employer to one person.

- The main example is ALife (ATO Longitudinal Information Files): de-identified tax return data, linked across years by a de-identified ID.
- Some people appear in some data files and not others, for example in some years and not others. This is normal, and it is where merges go wrong.
- Analysts work in different languages: R, Python, SQL or Excel. Write in the language of the template, and comment the code in plain words that explain the logic, not the syntax.

## Steps

Where a step says **Stop**, end your turn with your question as the last thing you write, and make no more tool calls until the analyst replies. Why: agent mode lets you keep going, and a check nobody answered is not a check.

1. **Check the request.** You need the data files to load, the exact variable names, and which table each name comes from. If a saved variable list exists, read it. If not, ask the analyst, then save their answer as the variable list. Why: a saved list can be checked against the data dictionary before any code is written, and the same name can appear in more than one table. If a data file, a name or a table is missing, or a name is not in the dictionary for that table, list what is wrong. Do not pick a close match. **Stop.**
2. **Pick the template.** Under Reference, each code template has a "use when" line. Use the one that fits the request. Copy it. Do not write from scratch. Why: a template already holds the file paths and the loading pattern that work on this data. If no template fits the request, say which part it does not cover, and do not stretch a template to fit. Why: a template built for one table will fail on another, or load the wrong thing. **Stop** only if no template fits.
3. **Fill in what the template asks for.** Read the top of the template to see what it asks for, and do not assume. Why: templates differ, and one may ask for things another does not. Fill in only that, using the data files and names from the variable list. Always keep the ID variable, because it is the only way to match a person across files.
4. **Load each data file.** If the same variable comes from more than one file, add the file's label to its name, such as the year. Why: after a merge, nothing else says which file a column came from.
   - If one data file: there is nothing to merge. Go to step 6.
   - If several: go to step 5.
5. **Merge, keeping everyone.** First check what one row stands for in each file: one person, or something finer, such as one person and one employer. If any file has more than one row for the same ID, tell the analyst and ask what one row should stand for in the result. **Stop** only in that case. Why: merging a file with several rows per person multiplies rows, and the result counts some people more than once. Then join the files on the ID variable with a full outer join: a join that keeps a record even when it is missing from a file, and leaves that file's values blank. Why: any other join drops those records without a warning, and the analyst ends up studying only people present in every file without having chosen to. Dropping people is the analyst's decision, never the join's. Leave blanks as blanks, and never turn them into zero. Why: a blank says the person was not in that file, and a zero says they were there and had none.
6. **Save the code file.** No analysis and no models. Why: this skill ends at data ready for a person to review.
7. **Count, then ask.** Report the rows loaded from each file, the rows after the merge, the number of unique IDs, how many people are missing from each file, and whether the result has one row for each thing the analyst said a row should stand for. Why: code that runs without an error proves nothing, and the counts are how a person catches a bad merge. Ask the analyst whether the counts are what they expect. **Stop.**

## Output

One commented code file that loads and merges, giving one row for each thing the analyst said a row should stand for (often a person), plus the counts from step 7. Every person, data file and variable is either in the result or reported as left out.

## Reference

The steps name no dataset, analysis, language or file. The lines below do. Each team fills in its own names in place of the square brackets. If a line is still in square brackets when you start, ask the analyst for it before step 2. Why: a guessed file name is a guess about the data.

- **Code templates:**
  - `ExampleDataOrg.R`. Use when the variables come from one table, for one year or several. \[Add each further template here on its own line: its name and location, then one sentence starting "Use when".\]
- **Variable list:** \[name and location of the saved list of agreed variables\].
- **Data files:** one folder for each table. The individuals table has one file for each year: `ALife_Individuals/aLife10_tax_[year].csv`. The folders sit in \[where your team keeps the data\].
- **Data dictionary:** `Dictionary.xlsx`. It has one sheet for each table, and the `alife_name` column holds the variable names. The same name can appear on more than one sheet. To check variable names, not to choose variables.
- **ID variable:** `alife_id_001`.
