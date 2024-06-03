-- NUMBER OF LEADS BY SOURCE

SELECT
	CASE 
		WHEN lead_source IN ('trade show', 'CDC Conference 2024', 'FDB Conference 2023', 'Tech Expo 2024', 
		'Medical Conference 2024', 'Tech Expo 2023', 'Medical Conference 2023', 'conference') THEN 'event'
		ELSE lead_source
    	END AS 'Lead Source',
	COUNT(*) AS 'Total Leads'
FROM leads 
GROUP BY 
	CASE 
		WHEN lead_source IN ('trade show', 'CDC Conference 2024', 'FDB Conference 2023', 'Tech Expo 2024', 
		'Medical Conference 2024', 'Tech Expo 2023', 'Medical Conference 2023', 'conference') THEN 'event'
		ELSE lead_source
    	END
ORDER BY COUNT(*) DESC
;


-- NUMBER OF LEADS BY STATUS

SELECT 
	lead_status AS 'Lead Status',
    	COUNT(*) AS 'Total Leads'
FROM leads
GROUP BY lead_status
ORDER BY COUNT(*) DESC
;


-- NUMBER OF LEADS BY INDUSTRY

SELECT 
	industry AS 'Industry',
    	COUNT(*) AS 'Total Leads'
FROM leads
GROUP BY industry
ORDER BY COUNT(*) DESC
;


-- NUMBER OF LEADS BY REGION 

WITH all_regions AS (
    SELECT 'APAC' AS region
    UNION ALL
    SELECT 'LAD'
    UNION ALL
    SELECT 'MEA'
    UNION ALL
    SELECT 'NA'
    UNION ALL
    SELECT 'NDEE'
    UNION ALL
    SELECT 'WSE'
)
SELECT
    ar.region AS 'Region',
    COUNT(l.lead_id) AS 'Total Leads'
FROM all_regions AS ar
LEFT JOIN leads AS l ON ar.region = l.region
GROUP BY ar.region
ORDER BY COUNT(l.lead_id) DESC
;


-- CONVERSION RATES BY SOURCE

SELECT
	CASE 
		WHEN lead_source IN ('trade show', 'CDC Conference 2024', 'FDB Conference 2023', 'Tech Expo 2024', 
		'Medical Conference 2024', 'Tech Expo 2023', 'Medical Conference 2023', 'conference') THEN 'event'
		ELSE lead_source
    	END AS 'Lead Source',
    	COUNT(*) AS 'Total Leads',
	SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END) AS 'Converted Leads',
	(SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS 'Conversion Rate'
FROM leads
GROUP BY 
	CASE 
		WHEN lead_source IN ('trade show', 'CDC Conference 2024', 'FDB Conference 2023', 'Tech Expo 2024', 
		'Medical Conference 2024', 'Tech Expo 2023', 'Medical Conference 2023', 'conference') THEN 'event'
		ELSE lead_source
    	END
ORDER BY (SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END) / COUNT(*)) * 100 DESC
;


-- CONVERSION RATES BY INDUSTRY 

SELECT 
	industry AS 'Industry',
    	COUNT(*) AS 'Total Leads',
    	SUM( CASE WHEN lead_status = 'converted' THEN 1 ELSE 0 END) AS 'Converted Leads',
    	(SUM( CASE WHEN lead_status = 'converted' THEN 1 ELSE 0 END)) / COUNT(*) *100 AS 'Conversion Rate'
FROM leads
GROUP BY industry
ORDER BY (SUM( CASE WHEN lead_status = 'converted' then 1 else 0 end)) / COUNT(*) *100 DESC
;


-- AVERAGE TIME IN EACH STAGE

SELECT
	lead_status AS 'Lead Status',
    	AVG(DATEDIFF('2024-06-01', created_date)) AS 'Average Days in Stage'
FROM leads
GROUP BY lead_status
ORDER BY AVG(DATEDIFF('2024-06-01', created_date))
;


-- SALES REP PERFORMANCE

SELECT
    s.user_id AS 'Employee ID',
    s.first_name AS 'First Name',
    s.last_name AS 'Last Name',
    s.department AS 'Department',
    COUNT(DISTINCT COALESCE(a.lead_id, i.lead_id)) AS 'Total Leads Involved',
    COUNT(DISTINCT a.lead_id) AS 'Leads Assigned',
    COUNT(DISTINCT i.lead_id) AS 'Leads Interacted With',
    SUM(DISTINCT CASE WHEN l.lead_status = 'converted' THEN 1 ELSE 0 END) AS 'Converted Leads'
FROM sales_team AS s
LEFT JOIN lead_assignments AS a ON s.user_id = a.user_id
LEFT JOIN interactions AS i ON s.user_id = i.user_id
LEFT JOIN leads AS l ON i.lead_id = l.lead_id
GROUP BY s.user_id
ORDER BY COUNT(DISTINCT COALESCE(a.lead_id, i.lead_id)) DESC
;


-- FACTORS FOR SUCCESSFUL CONVERSIONS

SELECT
	l.lead_id AS 'Lead ID',
    	l.company AS 'Customer',
    	l.industry AS 'Industry',
    	l.lead_source AS 'Lead Source',
    	l.country AS 'Country',
    	o.product_interest AS 'Product Interest',
    	DATEDIFF('2024-06-01', l.created_date) AS 'Age',
    	COUNT(i.interaction_type) AS 'Total Interactions'
FROM leads AS l
INNER JOIN opportunities AS o ON l.lead_id = o.lead_id
LEFT JOIN interactions AS i ON l.lead_id = i.lead_id
WHERE l.lead_status = 'converted'
GROUP BY l.lead_id, l.company, l.industry, l.lead_source, l.country, o.product_interest
;


-- AGING LEADS

SELECT
	l.lead_id AS 'Lead ID',
    	l.company AS 'Company',
    	l.lead_status AS 'Lead Status',
    	DATEDIFF('2024-06-01', l.created_date) AS 'Days in Pipeline',
    	COUNT(i.lead_id) AS 'Total Interactions'
FROM leads AS l
LEFT JOIN interactions AS i ON l.lead_id = i.lead_id
WHERE l.lead_status NOT IN ('converted', 'lost')
GROUP BY l.lead_id
ORDER BY DATEDIFF('2024-06-01', l.created_date) DESC
;


-- REASONS FOR LOST LEADS

SELECT
	l.lead_id AS 'Lead ID',
    	l.company AS 'Customer',
    	l.industry AS 'Industry',
    	l.lead_source AS 'Lead Source',
    	l.country AS 'Country',
    	o.product_interest AS 'Product Interest',
    	COUNT(i.interaction_type) AS 'Total Interactions'
FROM leads AS l
LEFT JOIN opportunities AS o ON l.lead_id = o.lead_id
LEFT JOIN interactions AS i ON l.lead_id = i.lead_id
WHERE l.lead_status = 'lost'
GROUP BY l.lead_id, l.company, l.industry, l.lead_source, l.country, o.product_interest
;


-- PATTERNS AMONG LOST LEADS

SELECT 
	l.company AS 'Company',
    	l.lead_id AS 'Lead ID',
    	l.industry AS 'Industry',
    	l.lead_source AS 'Lead Source',
    	l.region AS 'Region',
    	i.interaction_type AS 'Interaction Type',
    	DATEDIFF('2024-06-01', l.created_date) AS 'Days in Pipeline'
FROM leads AS l 
LEFT JOIN interactions AS i ON l.lead_id = i.lead_id
WHERE l.lead_status = 'lost'
ORDER BY l.lead_source
;


-- DETAILS OF OPPORTUNITIES

SELECT DISTINCT
    l.lead_id AS 'Lead ID',
    l.company AS 'Lead Company', 
    l.country AS 'Country',
    o.product_interest AS 'Product Interest', 
    o.estimated_value AS 'Estimated Value', 
    o.stage AS 'Stage', 
    s.first_name AS 'Responsible', 
    s.department AS 'Department'
FROM leads AS l
INNER JOIN opportunities AS o ON l.lead_id = o.lead_id
LEFT JOIN lead_assignments AS a ON l.lead_id = a.lead_id
LEFT JOIN sales_team AS s ON a.user_id = s.user_id
ORDER BY 
    FIELD(o.stage, 'closed', 'negotiation', 'proposal', 'qualification', 'prospecting'),
    o.estimated_value DESC
;


-- OPPORTUNITIES AND ESTIMATED VALUE BY STAGE

SELECT
    	stage AS 'Stage', 
    	COUNT(*) AS 'Number of Opportunities',
	SUM(estimated_value) AS 'Total Estimated Value'
FROM opportunities
GROUP BY stage
ORDER BY COUNT(*) DESC
; 


-- PRODUCT INTEREST ANALYSIS

SELECT
	product_interest AS 'Product Interest',
    	COUNT(*) AS 'Number of Opportunities',
    	SUM(estimated_value) AS 'Total Estimated Value'
FROM opportunities
GROUP BY product_interest
ORDER BY SUM(estimated_value) DESC
;
