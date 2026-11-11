# define-need

## 1. What it does
This skill turns a broad policy or research question into a precise data request: the exact comparison, the years to compare, the variables needed, and the assumptions that must be confirmed before any code or data lookup starts.

It is a conversation-first skill. The analyst says what they want in plain English, and the skill converts that into a short, testable brief that can be handed to the next skill without guesswork.

## 2. Technical or non-technical
This is primarily non-technical. The analyst and the AI talk through the question, the population, the years, and the variables. It becomes technical only when they check whether a variable or year is available in the ALIFE (Australian Longitudinal Information File) data dictionary or a file naming convention.

## 3. Steps
1. Intake the analyst's question
   - Input: one plain-English question, such as a bracket creep comparison between two tax years.
   - What the skill does: asks what the analyst is trying to compare, who is in scope, and what a usable answer would look like.
   - Output: a short plain-English problem statement and the main decision needed.

2. Confirm the comparison frame
   - Input: the policy or research question.
   - What the skill does: defines the target population, the years to compare, and whether the comparison is within the same people across multiple years or a cross-sectional snapshot for one year.
   - Output: explicit years, a population definition, and a simple statement of what is being compared.

3. List the variables needed
   - Input: the comparison frame and the analyst's intent.
   - What the skill does: names the variables needed for the comparison and separates the required variables from nice-to-have ones. It also asks whether some variables are needed for filters, labels, or matching rather than for the final output.
   - Output: a short variable list with reason for each variable.

4. Check assumptions before moving on
   - Input: the years and the variable list.
   - What the skill does: records assumptions that affect the result (for example, whether people need to be present in both years, whether missing values mean zero or missing, or whether the comparison is before-tax or after-tax). It asks the analyst to confirm any assumption the result could change.
   - Output: an assumptions log ready for the next skill.

5. Write the handoff brief
   - Input: the agreed question, years, variables, and assumptions.
   - What the skill does: writes a short brief that the next skill can act on without asking the analyst for the same context again.
   - Output: a single needs brief for the find-data skill.

## 4. Inputs and handoff
Start when the analyst has at least one real question and enough context to say what they need compared, even if the exact variable names are not known yet.

The skill needs:
- the business or policy question in plain English;
- the years or period to compare;
- a rough idea of the population and whether it is individual-level or group-level;
- a first pass at the variables needed.

The handoff to find-data is a needs brief containing:
- the question in plain English;
- the exact years or period;
- the target population;
- the approved variable list;
- the assumptions to carry into the data lookup.

## 5. If-then options
There are three common branches.

1. One-year request: if the analyst only needs a single year's data, the skill stays focused on confirming the single-year population and variables and does not spend time on cross-year matching.
2. Cross-year comparison: if the analyst needs a before-and-after comparison, the skill adds the exact years, the matching logic, and the assumptions about whether the same people are being followed across time.
3. Missing or unclear scope: if the analyst cannot say what counts as a valid result, the skill pauses and asks for the target population or the outcome definition before continuing.

## 6. Stop points
The skill must pause when any of the following is unclear:
- the question is too broad to measure;
- the analyst cannot say which years matter;
- the target population is unclear (for example, “all workers” versus “people in the tax system”);
- the exact variables are not known and the analyst cannot say what the data must answer;
- the assumptions could change the result materially.

At each stop point, the person checks the question, the population, the years, and the variable list before the skill continues.

## 7. Reference files
This skill mainly uses the analyst's own brief and confirmation notes. It may also read the ALIFE data dictionary to confirm that a concept is real and to check whether several variable names could refer to the same concept.

Reference file used in the workshop:
- `specs/references/Dictionary.xlsx` — used to check whether a concept is represented in the ALIFE variable catalogue and to understand what a candidate variable is measuring.

## 8. Hooks and other special conditions
There is no required hook in this skill because the main work is conversational and judgement-based. The skill should stop for a person whenever a definition or assumption is ambiguous.

The only useful deterministic check here is a lightweight checklist: before handing off, confirm the brief contains a question, years, population, variables, and assumptions. If any are missing, pause and ask the analyst to complete them.

## 9. What good looks like
A good output is a clear one-page brief that an analyst or another skill can act on without extra clarification.

Example bracket creep request:
- Request: “Compare bracket creep between 2015 and 2025 for people in the tax data, using the same people who are present in both years and looking at taxable income and tax schedule variables.”
- Acceptable answer: a brief that names the target population, the two years, the variables to compare, and the assumptions that are being tested before any code is written.

## 10. Watch out for
- Treating a broad policy idea as if it were a precise data request.
- Forgetting to state the population and the comparison years.
- Mixing variables that answer different questions, such as income, tax payable, and employer payments, without separating them.
- Assuming a variable exists or is comparable across years without checking the dictionary.
- Letting the conversation end without a short written brief for the next skill.

Justin spots these by forcing the brief to say exactly what is being compared, how the population is defined, and which assumptions matter.

## 11. Core or personal
Core steps:
- define the policy question;
- set the years;
- state the target population;
- list required variables;
- confirm assumptions before handoff.

Personal style:
- Justin keeps a short assumptions log and tests each decision against what would materially change the result.
- He is especially careful about the difference between a variable that is available and a variable that is actually the correct one for the question.

## Decisions
- Decision: split the work into a conversation-first skill followed by dictionary lookup and then code generation. Reason: the analyst has to define the question before code can be correct.
- Decision: keep the handoff as a single brief instead of passing free-form notes. Reason: the next skill should not have to re-ask the same questions.
- Decision: define the bracket creep example as a cross-year comparison of the same population rather than a loose year-to-year trend. Reason: bracket creep is only meaningful when the base population and years are explicit.

## Unknowns
- [unknown] the exact wording of the final analyst brief for any specific workshop example beyond the bracket creep case.
- [unknown] which exact variables will be used for the workshop's final worked example if the analyst changes the brief later.
- [unknown] any final tax threshold rules or schedule details not included in the project material.
