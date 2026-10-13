# Clothing Review Analysis

What are the common complaints in bad reviews on an online clothing store? I used SQL to analyze 23,486 customer reviews to find which complaints are most associated with low ratings, then rebuilt the analysis as an interactive Power BI dashboard.

## Dashboards

**Power BI**

[View file](clothing_review_dashboard.pbix)

![Power BI Dashboard](clothing_review_dashboard.png)

**Google Sheets**

[View file](https://docs.google.com/spreadsheets/d/1bJFrMr7xxGVRH-3CAEHQSVkY3ScJIu_n8PR3xwkEYrY/edit?usp=sharing)

![Google Sheets Dashboard](dashboard.png)

## Data

[Women's E-Commerce Clothing Reviews](https://www.kaggle.com/datasets/nicapotato/womens-ecommerce-clothing-reviews) (Kaggle). Each review includes a star rating, whether the customer would recommend the item, the department and product type, and the review text.

I compared low-rated reviews (1-2 stars, 2,407 reviews) with high-rated reviews (4-5 stars, 18,208 reviews).

**Tools:** SQLite (DB Browser for SQLite), Google Sheets, Power BI (Power Query, DAX)

## Findings

1. **Fabric is more closely tied to bad reviews than sizing.** Fabric complaints appear about 3.5x more often in bad reviews than good ones (15% vs 4.3%). Sizing complaints appear only about 1.7x more often (9.7% vs 5.8%).
2. **Customers with fabric complaints are the least likely to recommend.** 39.6% of customers with fabric complaints wouldn't recommend the item, compared to 25.2% with sizing complaints and 17.8% overall.
3. **Customers mostly complain about how fabric looks and feels.** "Cheap" is the top complaint in bad reviews (173), followed by see-through fabric (65). Holes, pilling, and shrinking are much less common.
4. **Sweaters have the biggest fabric problem in Tops.** Bad-review rates are similar across departments (8-11%), but sweaters have the most fabric complaints among bad reviews in Tops (20.6%).
5. **Jackets have the highest fabric complaint rate.** 24.7% of bad jacket reviews mention fabric problems, the highest of any product type with 50+ bad reviews.

## Power BI Build

- **Power Query:** Grouped ratings into Bad (1-2), Neutral (3), and Happy (4-5), and created fabric and sizing complaint flags using the same keyword logic as the SQL, including the armhole fix.
- **DAX:** Wrote measures for total reviews, fabric and sizing complaint rates, and the percent of customers who wouldn't recommend, including rates for customers with each complaint type.
- **Dashboard:** Added a department filter, summary cards, key findings, and three charts comparing complaint rates by rating, by product type, and by recommendation.

## How I Checked My Results

- **Compared against good reviews.** Searching for "size" alone was misleading, since happy customers mentioned it positively. I switched to specific problem phrases like "runs small."
- **Read random samples of matches.** In 30 fabric matches, 24 were real complaints. The other 6 were about armholes, which "holes" was accidentally matching, so I fixed the search. All 20 "cheap" matches were real quality complaints.
- **Caught compliments that were counted as complaints.** In happy sweater reviews, 8 of 20 matches were compliments like "not itchy," so I adjusted my sweater finding.
- **Matched SQL and Power BI.** Every complaint rate and recommendation rate in Power BI matched my SQL results.

## Limitations

- Keyword searches can't tell "itchy" from "not itchy," so some compliments were counted as complaints.
- The results show correlation, not causation. Complaints are linked to low ratings, but that doesn't prove they cause them.
- The data is nine years old.

## Recommendations

- Prioritize fabric quality over sizing.
- Start with sweaters, jackets, and thin fabrics, and review opacity with suppliers.
- Make product photos and descriptions show fabric thickness and opacity accurately.

## Files

- [clothing_analysis.sql](clothing_analysis.sql): all my SQL queries grouped by finding.
- [clothing_review_dashboard.pbix](clothing_review_dashboard.pbix): the Power BI dashboard file.
