# Taxable income analysis brief

## Problem and purpose

Separate real taxable-income growth from bracket creep to inform whether and how Australian personal income-tax thresholds should be indexed.

## Analysis question

Compare taxable-income distributions for tax-income years 2015 and 2025, and quantify tax at each percentile under counterfactual threshold-indexation scenarios.

## Population and unit

- Individuals in each year as repeated cross-sections, not a matched cohort.
- Unweighted records with non-missing taxable-income values, including zero and negative taxable income or loss.
- Use `income_year` values 2015 and 2025.

## Variables

- `ic_taxable_income_loss`: taxable income or loss.
- `income_year`: tax income year.

Both fields were checked in the individuals table of `alife_material/Dictionary.xlsx`.

## Table and calculations

- Report percentiles P1 through P99 in one-point increments, excluding the minimum and maximum.
- Show the taxable-income cut-off and tax liability calculated at that cut-off for each scenario.
- Deflate 2025 taxable income to 2015 dollars using actual cumulative Australian CPI.
- Apply every tax schedule to both years' income distributions.

## Tax scenarios

1. 2015 schedule with thresholds frozen in nominal terms.
2. 2015 schedule with thresholds indexed under actual cumulative CPI.
3. 2015 schedule with thresholds indexed under constant annual inflation of 2%.
4. 2015 schedule with thresholds indexed under constant annual inflation of 3%.
5. 2015 schedule with thresholds indexed under constant annual inflation of 4%.
6. Actual 2025 schedule.

Use Australian-resident individual statutory income-tax rates and thresholds for all records. Exclude offsets and the Medicare levy. Treat resident status for all records as a simplifying assumption.
