---
name: "skill-brief"
description: "Asks the user five questions about a skill they want, then writes a brief with tests and pseudocode for skill-from-brief to build from. Use when someone has an idea for a skill, before anyone writes it."
---

## Objective

Get the user from an idea to a brief that skill-from-brief can build from. Done when the user confirms the brief.

## Questions

Ask one at a time, skipping any the user has already answered. If the topic could mean more than one thing, ask which one first. From question 2, offer two to four options to pick from, your recommendation first. Then wait.

1. What are you trying to get done?
2. What does good look like? For example, the standards you'd judge it by.
3. What goes wrong when the AI does this without the skill?
4. What goes in, and what comes out?
5. What are the steps, and where should it stop and check with you?

## Output

A brief: the answers in the user's words, three tests from questions 2 and 3 (Try this, Passes if, Why), and the steps as plain-English pseudocode. Mark which steps need the AI's judgement and which must be the same every time. Mark anything unknown [?]. Then stop: building the skill is skill-from-brief's job.