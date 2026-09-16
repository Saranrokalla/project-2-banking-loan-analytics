-- Banking Loan Application & Credit Risk Analytics
-- PostgreSQL-style SQL; synthetic portfolio dataset
-- Table name: banking_loan_applications

-- 1. Overall application KPIs
SELECT
  COUNT(DISTINCT application_id) AS applications,
  COUNT(DISTINCT application_id) FILTER (WHERE decision_status='Approved') AS approved,
  COUNT(DISTINCT application_id) FILTER (WHERE decision_status='Rejected') AS rejected,
  COUNT(DISTINCT application_id) FILTER (WHERE decision_status='Pending') AS pending,
  ROUND(100.0 * COUNT(DISTINCT application_id) FILTER (WHERE decision_status='Approved')
        / NULLIF(COUNT(DISTINCT application_id) FILTER (WHERE decision_status IN ('Approved','Rejected')),0),2) AS approval_rate
FROM banking_loan_applications;

-- 2. Monthly application trend
SELECT DATE_TRUNC('month', application_date) AS month,
       COUNT(DISTINCT application_id) AS applications
FROM banking_loan_applications
GROUP BY 1 ORDER BY 1;

-- 3. Approval/rejection by loan type
SELECT loan_type,
       COUNT(*) AS applications,
       COUNT(*) FILTER (WHERE decision_status='Approved') AS approved,
       COUNT(*) FILTER (WHERE decision_status='Rejected') AS rejected
FROM banking_loan_applications
GROUP BY loan_type ORDER BY applications DESC;

-- 4. Regional performance
SELECT region,
       COUNT(*) AS applications,
       ROUND(100.0*COUNT(*) FILTER(WHERE decision_status='Approved')
       / NULLIF(COUNT(*) FILTER(WHERE decision_status IN ('Approved','Rejected')),0),2) AS approval_rate,
       ROUND(AVG(processing_days),2) AS avg_processing_days
FROM banking_loan_applications
GROUP BY region ORDER BY applications DESC;

-- 5. Turnaround time
SELECT decision_status,
       ROUND(AVG(processing_days),2) AS avg_processing_days,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY processing_days) AS median_processing_days
FROM banking_loan_applications
WHERE decision_date IS NOT NULL
GROUP BY decision_status;

-- 6. Credit-score band analysis
SELECT credit_score_band,
       COUNT(*) AS applications,
       ROUND(100.0*COUNT(*) FILTER(WHERE decision_status='Approved')
       / NULLIF(COUNT(*) FILTER(WHERE decision_status IN ('Approved','Rejected')),0),2) AS approval_rate
FROM banking_loan_applications
GROUP BY credit_score_band
ORDER BY credit_score_band;

-- 7. Channel analysis
SELECT channel, COUNT(*) applications,
       COUNT(*) FILTER(WHERE decision_status='Approved') approved,
       ROUND(AVG(processing_days),2) avg_processing_days
FROM banking_loan_applications
GROUP BY channel ORDER BY applications DESC;

-- 8. Customer segment analysis
SELECT customer_segment, COUNT(*) applications,
       COUNT(*) FILTER(WHERE decision_status='Rejected') rejected
FROM banking_loan_applications
GROUP BY customer_segment ORDER BY applications DESC;

-- 9. Pending applications
SELECT region, loan_type, COUNT(*) pending_applications
FROM banking_loan_applications
WHERE decision_status='Pending'
GROUP BY region, loan_type
ORDER BY pending_applications DESC;

-- 10. Data-quality checks
SELECT
  COUNT(*) AS total_rows,
  COUNT(*) FILTER(WHERE application_id IS NULL) AS missing_application_id,
  COUNT(*) FILTER(WHERE application_date IS NULL) AS missing_application_date,
  COUNT(*) FILTER(WHERE decision_status IS NULL) AS missing_status,
  COUNT(*) FILTER(WHERE decision_date IS NOT NULL AND decision_date < application_date) AS negative_processing_dates
FROM banking_loan_applications;
