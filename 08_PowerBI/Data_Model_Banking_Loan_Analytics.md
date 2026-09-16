# Power BI Data Model

## Recommended Model

### Fact Table
`banking_loan_applications`

Contains application-level records and analytical measures.

### Dimension Tables
`Calendar`
- Date
- Year
- Month Number
- Month Name
- Quarter

`Loan Type`
- Loan Type

`Region`
- Region

`Customer Segment`
- Customer Segment

`Channel`
- Channel

### Relationship
`Calendar[Date]` 1 → * `banking_loan_applications[application_date]`

Use single-direction filtering from the Calendar dimension to the fact table.

## Modeling Guidance
- Keep application_id unique at the fact grain.
- Use dimensions for slicers when practical.
- Keep KPI definitions in measures rather than hard-coded report values.
- Validate relationships before building visuals.
