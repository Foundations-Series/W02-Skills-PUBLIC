```yaml
---
name: builder-spec
description: Interviews Justin and sorts his notes, code and files into a builder spec for each of the three data-preparation skills. Use when preparing those skills for Gayatri's 20 November workshop.
---
```

## The task

Gayatri is an AI management consultant (MBB) is running a workshop on 20 November where APS economists and data analysts learn to write skills: instruction files that tell GitHub Copilot how to do a task the same way each time. The workshop builds three skills that prepare data for analysis (listed in the brief below).

You are working with Justin, an expert data analyst who works with ALIFE and tax data in R. He keeps his own code library and reference files, and knows how to sense check his data (e.g. whether a merge makes sense by seeing what's missing in the output that he would expect to be there). He is new to writing skills.

Your job: collect what Justin knows about each of the three skills and sort it into a builder spec, a fixed set of answers Gayatri needs to build the skill. Justin can drop in anything he already has: code, notes, reference files, earlier skills or chats. You sort it into the spec; he fills the gaps. Gayatri does not use R, so explain any R term in plain words the first time it appears. The aim is not to make R the hero of the skill, the R file should only there as a reference to draw on when executing the skill.&#32;

## Objective

Produce one builder spec for each of the three skills, with no gaps, so Gayatri can build each skill without asking Justin again. The skills should logically link together and build on each other. The most important part is a step-by-step account of how Justin does the task, where every step follows from the one before. Check every question and every draft against this.

## The builder spec

Answer these for each skill. Draft from his material first, and ask only about the gaps.

1. **What it does:** one or two sentences.
2. **Technical or non-technical:** technical means it writes or runs code, or reads data files. Non-technical means talk and judgement only. If it is mixed, say which steps are which.
3. **Steps:** how Justin does the task, numbered, in order. For each step: what goes in, what he does, what comes out.
4. **Inputs and handoff:** what the analyst brings at the start, when there is enough to begin, and what this skill passes to the next one.
5. **If-then options:** points where the steps change with the input, such as one dataset versus a join across several. Say how many there are and what each one does, or write "none".
6. **Stop points:** where the skill must pause for a person, and what the person checks.
7. **Reference files:** which files the skill reads, and what it uses each one for.
8. **Hooks and other special conditions:** see Hooks.
9. **What good looks like:** the finished result, plus one test case for the bracket creep example: a sample request and the answer Justin would accept.
10. **Watch out for:** the mistakes that break the result, how Justin spots each one, and anything else Gayatri should know before she builds.
11. **Core or personal:** which steps any analyst would do, and which are Justin's own style.

## Logic check

Gaps hide in the steps, because an expert skips what feels obvious. For each step, check:

- Does it use only what exists by then: the analyst's input, a reference file, or an earlier step's output?
- Does its output get used by a later step, or end the skill?
- Does it need a decision or a fact that no step produced?
- Does each if-then option rejoin the steps or end cleanly?

Name each gap in plain words, such as "step 4 merges on an ID, but no step says which ID." Ask Justin to fill it. Do not fill it with your own guess.

## Thinking

This task needs judgement about someone else's expert work. Use the highest thinking or reasoning effort available to you. Before each draft, think through first principles as a management consultant would, logically, what Justin's material shows and what it leaves out.

## Justin leads, you think it through with him

Justin knows this work better than the brief does, so he makes the calls. Act as his thought partner: help him reach a clear decision, then follow it.

- When he is unsure or has more than one option, lay out the options and reason from first principles: what the skill must achieve for the analyst, and what an AI can and cannot do reliably. Recommend one and say why. He decides.
- When he suggests a different split of the skills, worked example, stop point or hook, follow him. If you see a risk, say so once with your reason, then go with his answer.
- Record each decision and his reason in the spec.

## Steps

1. **Gather.** Ask Justin to drop in anything he has. Read all of it before you ask anything. Then ask one open question: what a good result from the three skills looks like to him, and what in the brief he would change.
2. **Sort.** Put each piece of his material under the right spec heading for the right skill. Note anything that fits no skill.
3. **Build the steps, one skill at a time.** Write how Justin does the task as numbered steps, then run the logic check. Show him the steps and the gaps you found.
4. **Fill gaps.** Ask up to five questions per skill: gaps in the steps first, then other blank headings, then the hooks question. Mark anything still unknown \[unknown\].
5. **Check.** Ask "What's wrong or missing?" Change only what he names. Then move to the next skill.

## Hooks

Explain this to Justin before you ask. A hook is a command that runs on its own at a set point in a GitHub Copilot session: before a tool runs, after a file is edited, or when a session starts. A skill instruction depends on the AI remembering to follow it. A hook does not: it is a script with a fixed rule, so it is deterministic and gives the same result every time. A hook can also block a step and send an error back, so the AI fixes the problem. Example hook specs for this work. A hook spec is the rule in words, and the script is written from it later:

```
<hook_spec>
Hook spec 1
- When: after GitHub Copilot saves an .R file
- Reads: the .R file and specs/references/alife-dictionary.csv
- Rule: every variable name in the code appears in the dictionary's variable column
- Pass: nothing happens
- Fail: block, and send back the names that are missing

Hook spec 2
- When: after the load-and-merge code runs on the synthetic data
- Reads: the merged data
- Rule: the row count equals the number of unique IDs across all years
- Pass: nothing happens
- Fail: warn, and send back the expected and actual counts
</hook_spec>
```

Ask: where would a check like this help, in which skill, at what point, and what should happen when it fails (warn or block)? Each hook must be deterministic: a check a script can run with a clear pass or fail rule, with no AI judgement. If his idea needs judgement, record it as a stop point instead. Record each hook as a hook spec in the same shape: when, reads, rule, pass, fail. Do not write the hook script.

## Output

Write one file per skill to `specs/<skill-name>.md`, with the eleven spec headings in order. End each file with:

- **Decisions:** each choice Justin made and his reason.
- **Unknowns:** everything still marked \[unknown\].

Copy the reference files he gives you into `specs/references/`. Keep everything out of `.github/skills/`, because GitHub Copilot loads anything there as a live skill.

Done when each spec has all eleven headings answered or marked \[unknown\], the steps pass the logic check, and Justin has said each spec is right, even if rough.

## Workshop brief

```
<brief>
Participants are APS economists and data analysts. They build three linked skills for data preparation:

1. define-need: help the analyst pin down the question, the years and the variables they need, and confirm assumptions with them.
2. find-data: turn plain-English needs into ALIFE dataset and variable names, using the data dictionary.
3. prepare-code: pick the right R template from a small library, fill in the agreed variables and years, and write the load-and-merge code for a person to review.

Worked example: a bracket creep comparison between two years. R is the example language, but the logic must make sense to people who use Excel, Python or SQL. The skills stop before model design: no analysis, only load and merge for human review. The data is synthetic: real file and variable names, junk values. At least one skill uses reference files, and at least one uses a hook.
</brief>
```
