# Testing the three skills: notes for Justin

Nov 12, 2026 · @Gayatri Kotnala

Thank you for testing these initial Skills. There are three skills, and each one has a single test below. Each test tells you what to type, what the skill should do, and what I would like you to tell me afterwards. Please run them in GitHub Copilot in agent mode, in a folder that holds the three skills, `Dictionary.xlsx`, `ExampleDataOrg.R` and the synthetic data.

A short reply to each question is all I need. If a skill does something you did not expect, please copy what it said and send it to me.

## Before you start

The skills leave a few things blank, because they differ from team to team. The skill should ask you for them the first time it needs them. They are the folder where the data files are kept, and the name and place of the file where the list of chosen variables is saved. In the final Skill we will need to point people somewhere.

## Test 1: define-need

Please type this: "I want a table of taxable income for 2015 and 2025."

This request names an output and does not say what l’s tax under each scenario, then summarize by income-percentile group.problem it solves. The skill should notice that. Before it asks about years or variables, it should ask what you are trying to find out and why it matters. It should ask a few numbered questions at a time, suggest an answer to each one, and then wait for your reply. At the end it should show you a short written summary and ask you to confirm it.

**Test: **Did it ask about the problem before anything else? Did it ask too many questions, or miss something you always ask?

## Test 2: find-data

Please type this: "I need taxable income, tax paid and date of birth for individuals, for 2015 and 2025."

The three items are chosen to give three different results.

- For taxable income, the skill should find one variable, which is (assume) `ic_taxable_income_loss`.
- For tax paid, there is no single variable. The skill should show you the candidates, such as `tc_net_tax`, say which one it recommends and why, and ask you to choose.
- For date of birth, the skill should tell you that the data does not hold it. It should offer the nearest variables, which are `c_age_30_june` and `c_birth_fy`, and ask whether either will do.

The skill should then stop and wait for you. It should save the list of variables only after you have answered, and the saved list should hold only the names you agreed to.

**Tests **Was Copilot able to read `Dictionary.xlsx` directly, or did it have to run some code to open it? Did it save anything before you had agreed to it? When an analyst says "tax paid", which variable would you choose, and why? What other tests can you think of?

## Test 3: prepare-code

This one is the one I am least sure of and probably needs your SME insight most of all.

I have also included handling for more complex analyses than the one we discussed, to see whether the skills can hold it. For example, the skills allow for a request that needs a table other than individuals, and for a table where one person has several rows. The test below does not use those parts, so they have not been tried yet. I would be interested in whether you think I need them, or whether the skills should cover only the single load and merge we agreed on.

Please type this: "Write the code to load ic\_taxable\_income\_loss and tc\_net\_tax from the individuals table for 2015 and 2025."

The skill should start from a copy of `ExampleDataOrg.R` and should not write new code from scratch. It should set the years to 2015 and 2025 only, and it should keep `alife_id_001`. People who appear in only one of the two years should still be in the result, with blanks for the year they are missing from. When it has finished, the skill should give you the number of rows it loaded for each year, the number of rows after the merge, and the number of people missing from each year. It should then ask you whether those numbers look right, and it should not go on to any analysis.

Please tell me three things. Was Copilot able to run the R code itself, or did you have to run it? Did the number of rows after the merge equal the number of different people across the two years? What did you have to change in the file paths to make the code run on your machine?

## One thing to add while you are testing

The prepare-code skill is built to choose between several code templates, and at the moment it has only one. If you have another one, for example one that links a person to their employer, please add it. In the Reference section of the skill there is a marked place for it. For each template, please write its name and where it is kept, followed by one sentence that starts with "Use when" and says which requests it suits. The skill reads only that sentence when it chooses, so the sentence should say what makes this template different from the others.

Once you have added one, please run one request that suits the new template and one that suits the old one, and tell me whether the skill chose correctly each time.

## Two questions about the data

Does the synthetic data include any tables other than the individuals table? The dictionary describes eight tables, and the template loads only one of them.

In tables where one person can have several rows in a year, such as payments from employers, what do you do before you merge them with other data?
