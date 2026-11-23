---
name: "skill-from-brief"
description: "Builds or checks a simple skill from the user's pseudocode or worked-through notes, such as a brief from skill-brief, for any AI tool that takes skills."
---

## Objective

Produce a full, working skill (a SKILL.md file, with any scripts it runs), worked out with the user and ready to install in Claude, ChatGPT or Copilot. Check every question, draft line and fix against this: does it help the user end up with the simplest skill that does the job?

## Input

You'll get an input from the user. It might be pseudocode, or notes where they have already thought it through, such as a brief from skill-brief. At a minimum, it should give you:

- What the skill is trying to get done.
- What goes in, and what comes out.
- The steps in order, and where the skill must stop and check with the user.
- What the user would call a pass and a fail, ideally with one real example of each.

If any of these is missing, ask for it. Otherwise, keep going.

## Steps

These steps build a new skill. For a skill the user already has, follow "Auditing a skill". A step that ends in **Stop** waits for the user before the next step starts, so the answer and the check are the user's. Each stop says what to check, and the wording is yours. Check the core things only, and give your recommendation and why, so the user can simply agree or change it. Draft early, so the user reacts to something concrete instead of answering questions in the abstract.

1. **Check the input.** Check it against the minimum in "Input". In one message, ask only for what's missing, and skip anything the input already answers. The user is the expert on what good looks like, so use their words for it. If nothing is missing, go to step 2.
2. **Decide the shape.** One skill or several, and steps, a standard or both (see "Two kinds of skill"). Decide on the objective, not the inputs: one objective is one skill however varied the inputs, and two objectives mean two skills. If the steps change for most inputs, check for a hidden second objective. Then decide, step by step, what the LLM does and what should be deterministic code (a script that gives the same result every time), such as a count or a check with one right answer. Recommend code only where the user's tool can run it. Recommend a shape. **Stop** to confirm it.
3. **Write the skill.** Write the full SKILL.md, all seven parts, and any script it runs, from what you have, in the user's words where they gave them. For each script, say in the Method when to run it and what a pass is. Mark each guess, and any best practice, persona or tag you add, as an assumption with the reason. Consider whether recognised best practice in the field (Minto's Pyramid Principle for storylines, ASD-STE100 for plain technical writing) or a persona (an experienced newspaper sub-editor for a skill that tightens copy) would focus the skill, because naming one points the LLM at a body of practice it already knows and can stand in for several rules. Add one only when it changes what the LLM would do, and pair a persona with what that person does differently, since a role on its own mostly changes tone.
4. **Fill the gaps.** In one message, ask up to three questions on the assumptions that would change the skill most. Anything still unknown stays as a listed assumption. **Stop.**
5. **Check, then ask for approval.** Check the skill first against what the user is trying to get done (from the input), then against "What a good skill looks like", and fix what fails. Show it. **Stop** for the user to approve it, change it or drop it. Save or change a skill file only after the user approves.

## Auditing a skill

Follow these steps when the user brings a skill they already have. Find the few lines that cause the problem, because a list of every flaw hides the fixes that matter.

1. **Get the problem and the evidence.** Ask for the skill, what went wrong, one real result that shows it, and what the user would call a pass and a fail for that result. The user is the expert on what good looks like, so use their words for it. If they have no result, ask for a request and run the skill on it to make one. **Stop.**
2. **Trace the cause.** Say what the skill is trying to do. If the result passes the user's own test, say the skill is doing its job, and finish. Otherwise, find the line that produced the result and quote it, so the user can see it for themselves. If no line did, name the gap, because the LLM fills a gap with its default. **Stop** to check you have the cause right.
3. **Propose the fewest fixes.** Give only those that would change the result, three at most. Rank them by how much each should change it, and say what should change. Put anything else that fails "What a good skill looks like" in one line, as optional. **Stop** for the user to choose which fixes stand.
4. **Test.** After the user approves, change a copy of the skill, and make only the fixes they approved. Run the same request before and after the change, with a fresh agent for the after run if the tool can start one, because the one that wrote the fix knows what a pass looks like. Show both results. If the tool can't run the skill, give the user the request to run. **Stop** for the user to judge the new result against their own pass and fail.

## What a good skill looks like

### Two kinds of skill

- **Steps:** a process in order, like turning any transcript into the same summary.
- **Standard:** rules the result must meet, in any order, like writing in someone's voice. In a standard skill, the standard is the Method; in a steps skill, the standard for good goes in Context.
- Many skills use both: steps that end with a check against a standard.

### The seven parts

"The LLM" means the AI model that will run the skill. The third column gives the first principle behind each part: a limit of the LLM. Cover all seven. By default, give each part its own subheading. If the user says something matters most, use your judgement (its own subheading, or merged parts), as long as every question below is answered.

| Part | Question to ask | Because the LLM... |
|---|---|---|
| Objective | Does it say, in one or two sentences, what the skill is solving for, and tell the LLM to check each step and the result against it? | falls back on the goal when a case isn't covered, so the goal must be short enough to recall at every step |
| Trigger | Does the description say, in one sharp sentence, what the skill does and when to use it? | sees only this until the skill starts, and reads every skill's description in every chat |
| Input | Does it say what the user must give, when there's enough to start, and what changes for each kind of input? A change in how the work is done goes in Method as "if this, then that". | guesses wherever there's a gap |
| Method | Does it say what the LLM does: steps in order, with a marked stop, and what it checks, before anything hard to undo and wherever the answer or the check is the user's, a standard, or both? | leans towards acting and finishing, so it runs past the user's answers and checks unless told where to stop |
| Context | Does it give the background the LLM wouldn't already know, like definitions, sources, any best practice or persona it works to, and who the result is for? | only knows what's in front of it |
| Guidelines and verification | Does it name the few mistakes that would break the result, each with what to do instead, and nudge the LLM to check its conclusions against something (the source, a quote, the user's words) in its own way? For each check, does it say who runs it (the user or the LLM) and what a pass is? | brings a banned thing to mind, and can sound sure while guessing |
| Output | Does it describe the result and where it goes, give one example that fits the people using it, and say what finished means? | copies examples closely, and stops when it thinks it's done |

### Can it be followed?

Ask of every line:

- Could someone new to the task follow it without asking what it means?
- Does it repeat or contradict another line anywhere in the skill, including any line just added or changed?

### Writing rules

Simplify the language using ASD-STE100 (Simplified Technical English) as a guide, so each line has one meaning the LLM can't misread.

- **Briefed:** write it as you'd brief a capable colleague: say what the result must be and why, and leave how to the LLM. Fix the how only where it must be the same every time: a stop, a check with one right answer, or a set format. Give the background they need and no more, because the LLM applies bare rules rigidly and a reason lets it handle cases the skill didn't list.
- **Concise:** less is more. Keep the lines that do most of the work (80/20) and cut the rest, even lines that are true and useful, because every extra line competes for the LLM's attention. Cut preamble. About 1,000 words is a rough guide, not a limit. Put the key rules at the top and bottom, because the LLM pays least attention to the middle of long text. If background starts to outweigh the instructions, suggest moving it into a reference file and let the user decide.
- **Precise:** use the one word that best gets the result the objective needs.
- **Checkable:** start each instruction with a verb, and make instructions and finish lines something the LLM can check ("short" becomes "under 100 words"). Leave judgement calls to the objective.
- **Tagged:** use subheadings to organise instructions, and wrap only material that isn't an instruction, such as an example, a template or text the user pastes in, in an XML tag named for what it is (`<example>`). The tag shows the LLM where that block starts and ends and that it's a sample, not an order. Keep tags in the body, since the name and description can't hold them.

## Guidelines and verification

- When changing a skill, the LLM tends to patch each gap by adding a line, and to cut what the skill needs because shorter looks better. Rewrite the line that needs to change instead of adding one after it. Before cutting, name what the user is trying to get done (from the input) and check the cut version still gets them there.

## Output

- **New skill:** the full SKILL.md and any scripts it runs, shown in chat and saved as files once the user approves, ending with how to install it in the user's AI tool (ask which, if the input doesn't say). Research the current steps for that tool if you're unsure, because how each tool installs skills changes often. Under it, list your assumptions and two or three test requests, each with the user's pass and fail from the input.
- **Audit:** the cause with its line quoted, three fixes at most, and the results before and after.

Example of a finished skill, so you match its shape:

<example>

---
name: meeting-summary
description: Turns a meeting transcript into a one-page summary of decisions and actions. Use when someone shares a transcript and asks for a summary.
---

## Objective
Turn any meeting transcript into the same one-page summary, so decisions and actions are easy to find. Check each item against that aim before including it.

## Input
The transcript, and who the summary is for. If speakers aren't named, ask who they are.

## Method
1. Ask who the summary is for. **Stop.**
2. Sort the talk into decisions, actions and open questions.
3. **Stop** for the user to check nothing is missing or misheard, before finalising.

## Context
The reader needs to see what was decided and who does what next, on one page.

## Guidelines and verification
Instead of guessing an owner, mark it [owner?]. Check each action against the transcript before listing it.

## Output
A one-page summary in chat, finished when every action has an owner or an [owner?] mark.

</example>

## Done when

You're done when the user has agreed the shape and approved a full skill that delivers what the user is trying to get done (from the input), with all seven parts covered and every line able to be followed. For an audit, you're done when the user has passed the result and the skill still meets its own objective.