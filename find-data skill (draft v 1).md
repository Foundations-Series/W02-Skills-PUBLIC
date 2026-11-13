```yaml
---
name: find-data
description: Turns what an analyst needs, said in plain words, into the exact ALife variable names from the data dictionary, then saves the agreed list for a person or another skill to use. Use when an analyst working with Australian Government microdata knows what they need and wants the real variable names.
---
```

## Objective

Turn what the analyst needs, said in plain words, into exact variable names that the load code can use. Done when every variable name comes from the dictionary and is one the analyst has seen and agreed to.

## Who you are helping

You help analysts in the Australian Public Service, mostly economists and data analysts. They work with Australian Government microdata: unit-record data, where each row is one record. A record is often one person in one year, but it can be finer, such as one payment from one employer to one person.

- The main example is ALife (ATO Longitudinal Information Files): de-identified tax return data, linked across years by a de-identified ID.
- The data has hundreds of variables with coded names. A name rarely tells you what it holds, so the data dictionary is the only safe way to read one.
- The analysts are expert in their field, but may not know this dataset's names. They can judge whether a variable fits their question once you show them what it holds.
- Facts are your job: what the dictionary says, you look up. Decisions are the analyst's: which variable fits their question, and whether a near match will do.

## Steps

you will be given plain english inputs by the analyst on the purpose of the analysis and the variables they require.&#32;

Where a step says **Stop**, end your turn with your question as the last thing you write, and make no more tool calls until the analyst replies. Why: agent mode lets you keep going, and a choice nobody made is a choice you made for them.

1. **Check the request.** You need each thing the analyst needs in plain words, such as "taxable income" or "age", who or what it is about, such as people, employers or companies, and which data they want it for, such as one year or several. A written brief or a plain list are both fine. If any of these is missing, ask.
2. **Look up each item in the data dictionary (`Dictionary.xlsx`).** Start with the tables that hold who or what the analysis is about, then check the others, and note which table each match is in. Why: the same name can appear in more than one table and mean something different in each. Read the label and the description, not only the name. Why: names are coded, and a name that looks right can hold something else. If the dictionary gives no description for a name, say so, and do not guess from the name.
3. **Show the matches.** One row per item: what they asked for, the variable name, which table it is in, what the dictionary says it holds, and one of three results.
   - **Exact:** one variable holds what they asked for.
   - **Several:** more than one could fit. List them all with what each holds, recommend one and say why.
   - **None:** nothing holds it exactly. Show the nearest variable and say how it differs. For example, ALife has no date of birth, only age at 30 June.

   You recommend, the analyst decides. Never write a "several" or a "none" into the load block until they agree. Why: a near match changes what the analysis measures, and only the analyst knows if that is acceptable. Ask: "Here are the variables I think you need and what each one holds. Are these right?" Word it so "yes" accepts your recommendations. **Stop.**
4. **Check the files.** Confirm each chosen variable is in every data file the request covers. Why: a variable missing from one file fails late, or loads as blanks nobody notices. If any are missing, list the variable and the file, and ask what to do. **Stop** only if something is missing.
5. **Save the agreed list.** Write one row per variable to the output file: what the analyst asked for, the variable name, which table it is in, and what the dictionary says it holds. Add the ID variable for each table, because it is the only way to match a record across files. Say which data files the list covers. Change no other file. Why: a saved list can be checked, and it can be used by a person or by code, in any language. Every variable name in it is one the analyst has seen and agreed to in step 3.

**Then write the load code.** **\[Placeholder, waiting on Justin: what the load code is for, which template it starts from, and what the options are\]**

## Output

The list of variables the analyst agreed to, saved to the output file.

## Reference

The steps name no dataset, analysis or file. The lines below do. Each team fills in its own names in place of the square brackets. If a line is still in square brackets when you start, ask the analyst for it before step 2. Why: you cannot look something up until you know where it is, and a guessed file name is a guess about the data.

- **Data dictionary:** `Dictionary.xlsx`. It has one sheet for each table. On every sheet the `alife_name` column holds the variable name, and the label or description column says what it holds. The only source for variable names and what they hold.
- **Data files:** one folder for each table. The individuals table has one file for each year: `ALife_Individuals/aLife10_tax_[year].csv`. The folders sit in \[where your team keeps the data\]. Shows which files exist and which variables each one holds.
- **Output file:** \[name and location of the file this skill saves the agreed list to\].

* **Load code template:** `ExampleDataOrg.R`. Use when the variables come from one table, for one year or several.
