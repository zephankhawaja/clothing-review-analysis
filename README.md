# Clothing Review Analysis

What are the common complaints in bad reviews on an online clothing store? I used SQL to analyze 23,486 customer reviews to find which complaints are most associated with low ratings.

[Dashboard (Google Sheets)](https://docs.google.com/spreadsheets/d/1bJFrMr7xxGVRH-3CAEHQSVkY3ScJIu_n8PR3xwkEYrY/edit?usp=sharing)

![Dashboard](dashboard.png)

## Data

[Women's E-Commerce Clothing Reviews](https://www.kaggle.com/datasets/nicapotato/womens-ecommerce-clothing-reviews) (Kaggle). Each review includes a star rating, whether the customer would recommend the item, the department and product type, and the review text.

I compared low-rated reviews (1-2 stars, 2,407 reviews) with high-rated reviews (4-5 stars, 18,208 reviews).

**Tools:** SQLite (DB Browser for SQLite), Google Sheets

## Findings

1. **Fabric matters more than sizing.** Fabric complaints appear about 3.5x more often in bad reviews than good ones (15% vs 4.3%). Sizing complaints appear only about 1.7x more often (9.7% vs 5.8%).
2. **Fabric complaints lower recommendations the most.** 39.6% of customers with fabric complaints wouldn't recommend the item, compared to 25.2% with sizing complaints and 17.8% overall.
3. **Customers mostly complain about how fabric looks and feels.** "Cheap" is the top complaint in bad reviews (173), followed by see-through fabric (65). Holes, pilling, and shrinking are much less common.
4. **Sweaters have the biggest fabric problem in Tops.** Bad-review rates are similar across departments (8-11%), but sweaters have the most fabric complaints among bad reviews in Tops (21%).

## How I Checked My Results

- **Compared against good reviews.** Searching for "size" alone was misleading, since happy customers mentioned it positively. I switched to specific problem phrases like "runs small."
- **Read random samples of matches.** In 30 fabric matches, 24 were real complaints. The other 6 were about armholes, which "holes" was accidentally matching, so I fixed the search. All 20 "cheap" matches were real quality complaints.
- **Caught compliments that were counted as complaints.** In happy sweater reviews, 8 of 20 matches were compliments like "not itchy," so I adjusted my sweater finding.

## Limitations

- Keyword searches can't tell "itchy" from "not itchy," so some compliments were counted as complaints.
- The results show correlation, not causation. Complaints are linked to low ratings, but that doesn't prove they cause them.
- The data is nine years old.

## Recommendations

- Prioritize fabric quality over sizing.
- Start with sweaters or thin fabrics and review opacity with suppliers.
- Make product photos and descriptions show fabric thickness and opacity accurately.

## Files

- [clothing_analysis.sql](clothing_analysis.sql): all my SQL queries grouped by finding.
