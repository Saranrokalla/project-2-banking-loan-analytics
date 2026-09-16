# Power BI Dashboard Requirements

## Dashboard Objective
Provide management and operational users with a single analytical view of the synthetic loan application lifecycle.

## Page 1 — Executive Overview
### KPI Cards
- Total Applications
- Approved Applications
- Approval Rate
- Rejection Rate
- Pending Applications
- Average Processing Days
- Median Processing Days

### Visuals
1. Monthly application trend
2. Applications by region
3. Applications by loan type
4. Approval rate by loan type
5. Average processing days by region
6. Decision-status distribution

### Slicers
- Application Date
- Region
- Loan Type
- Customer Segment
- Channel
- Decision Status

## Page 2 — Credit & Customer Analysis
- Approval rate by credit-score band
- Applications by customer segment
- Approval/rejection by customer segment
- Requested amount by loan type
- Channel performance
- Credit-score distribution

## Page 3 — Operations & Turnaround
- Average processing days by stage
- Average processing days by region
- Pending applications by loan type
- Processing-time distribution
- Monthly turnaround trend
- Data-quality exception count

## User Experience
- Keep KPI definitions visible through tooltip/help text.
- Use consistent filters across pages.
- Allow drill-down where useful.
- Display the reporting period clearly.
- Avoid exposing unnecessary application-level sensitive information.

## Acceptance Criteria
- All required KPIs reconcile to the source dataset.
- Filters update relevant visuals consistently.
- Approval rate follows the approved business rule.
- Turnaround time excludes invalid timestamp records.
- Dashboard supports the business questions in the BRD.
