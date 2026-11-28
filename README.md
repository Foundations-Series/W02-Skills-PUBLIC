# Building Reusable Skills: example skills

These are example skills from Building Reusable Skills, a Foundations Series workshop (Canberra, November 2026) presented by Gayatri Kotnala of [Pypline](https://pypline.com.au). They show what a skill looks like and how one is built. They are not finished products. Copy one, change it to fit your work, and test it before you rely on it.

## What's a skill?

A skill is a file of plain-English instructions that the AI follows for one task, so you don't type the same thing every time. You write it to the AI ("You help analysts…"). The few lines at the top are a label, so the AI knows what the file is and when to use it.

You don't need to code to write one. You need to know how you'd do the task yourself, and what a good result looks like.

## What's in here

| Folder | What it holds |
|---|---|
| [`building-skills/`](building-skills/) | Two skills for building skills, for any task. **[skill-brief](building-skills/skill-brief/SKILL.md)** asks you five questions about a skill you want and writes a brief. **[skill-from-brief](building-skills/skill-from-brief/SKILL.md)** builds the skill from that brief, or from your own pseudocode. |
| [`example-skills/`](example-skills/) | The three skills from the workshop: a chain for one kind of work, each handing its output to the next. **[define-need](example-skills/define-need/SKILL.md)** asks you questions until your analysis question is clear. **[find-data](example-skills/find-data/SKILL.md)** finds the right variable names in the data dictionary. **[prepare-code](example-skills/prepare-code/SKILL.md)** writes the code to load and merge the data. They were built for ALife (the ATO Longitudinal Information Files), de-identified tax data used by researchers, and are here as a worked example. In the workshop we used synthetic data laid out like ALife, not real tax data. No data, data dictionary or code library is included here. The skills point at those in square brackets, and you fill in where yours are. [`define-need/tests.md`](example-skills/define-need/tests.md) is an example of what tests for a skill can look like. |

## Build your own skill

Use the two skills in `building-skills/` when there's a task you keep doing with AI and you want a skill for it. Run them in order.

1. **skill-brief: run this first.** Before you write a skill, it asks you five questions, one at a time:
   - What are you trying to get done?
   - What does good look like?
   - What goes wrong when the AI does this without the skill?
   - What goes in, and what comes out?
   - What are the steps, and where should it stop and check with you?

   It turns your answers into a brief: your answers in your own words, three tests, and the steps as pseudocode (plain-English steps, one per line). Why: if you don't say what good looks like, the AI fills the gap with its own guess.
2. **skill-from-brief: run this second.** Give it your brief. It suggests a shape for the skill, checks it with you, then writes the full `SKILL.md`. It saves nothing until you approve it.

Already know your steps, and what a pass and a fail look like? Skip skill-brief and give your own pseudocode straight to skill-from-brief.

## How to use a skill

These work in any AI tool that takes skills or custom instructions, such as Claude, ChatGPT or Copilot.

1. Add the skill's `SKILL.md` to your tool, or attach it to a new chat.
2. Ask for the skill by name, then say what you need in your own words.
3. When the AI stops and asks you something, answer before it goes on.
4. If it answers for you without waiting, start a new chat.

## How to write your own

1. Write your tests first. Say how you'd check the result, and why. A test looks like: "Try this: … Passes if: … Why: …"
2. Write the steps as pseudocode: how you'd do the task yourself, one line per step, in plain words. Mark where the AI must STOP and wait for you, and what it must CHECK.
3. Run it. Check each test. Fix one thing. Run it again.

## Acknowledgements

A big thank you to Justin Holland at the ATO. The skills grew out of the way he works with his datasets, and he worked together with Gayatri Kotnala, the workshop facilitator, to co-design and create a set of skills that were fit for purpose.

Gayatri designed and presented the workshop. She is the founder of [Pypline](https://pypline.com.au), a firm that builds the AI operating system for organisations, from strategic choices to tools, agents and work redesign, with human judgement at the centre.

## Licence

[CC BY 4.0](LICENSE). You can copy and adapt these skills for any purpose, as long as you credit the Foundations Series and Gayatri Kotnala.
