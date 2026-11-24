# Example tests for define-need

This is an example of what tests for a skill can look like. It is not a full test set. Each test says what to try, what a pass looks like, and why. They come from a live run of the skill by an analyst.

| Test | Try this | Passes if | Why |
| --- | --- | --- | --- |
| Asks about the problem first | "I want a table of taxable income for 2015 and 2025." | Its first questions are about what you're trying to find out, not years or variables. | A table is an output, not a problem, and the problem decides which data you need. |
| Doesn't ask twice | A request that already names the years and who it's about. | The brief shows them, and no question asks for them again. | The analyst was asked things he'd already said. |
| Says who is in and what one row is | Any request. | The brief says who is in and out, and what one row of the result is. | "All workers" and "people in the tax system" give different answers, and the row decides whether files are merged, stacked or kept apart. |
| Says what a missing year means | A request that covers more than one year. | The brief says a missing year means "didn't lodge", not zero. | Blanks and zeros give different results. |
| Waits, then saves | Any request. | It stops after each round, and saves the brief only after you confirm. | In agent mode it keeps going unless the skill tells it to wait. |
