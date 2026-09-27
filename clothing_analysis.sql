-- Clothing Review Analysis
-- I wanted to find out whether bad reviews are more about fabric or sizing, and which products should be fixed first.
-- Uses the Women's E-Commerce Clothing Reviews dataset from Kaggle (23,486 reviews), loaded into SQLite as "reviews".
-- Low-rated = 1-2 stars (2,407 reviews), high-rated = 4-5 stars (18,208 reviews).



-- Finding 1: Sizing

-- I first searched for the word "size" alone, but happy reviews mentioned it more (32% vs 26%)
-- because of phrases like "true to size." I switched to specific problem phrases instead.
-- Sizing complaints appear ~1.7x more often in bad reviews (9.7% vs 5.8%).
-- I added armholes after noticing them while reading reviews. Most armhole mentions are in
-- 4-5 star reviews, so fit issues seem to not be an impactful issue.

-- 1a: low-rated (234 / 2,407 = 9.7%)
select count(*) from reviews
where rating <= 2
  and ("Review Text" like '%too small%' or "Review Text" like '%runs small%'
    or "Review Text" like '%too big%' or "Review Text" like '%runs large%'
    or "Review Text" like '%arm%hole%');

-- 1b: high-rated (1,059 / 18,208 = 5.8%)
select count(*) from reviews
where rating >= 4
  and ("Review Text" like '%too small%' or "Review Text" like '%runs small%'
    or "Review Text" like '%too big%' or "Review Text" like '%runs large%'
    or "Review Text" like '%arm%hole%');



-- Finding 2: Fabric

-- Fabric complaints appear ~3.5x more often in bad reviews (15% vs 4.3%), a bigger issue than sizing.
-- '%holes%' was also matching "armholes," which is a fit complaint, so I excluded those (see 2c).

-- 2a: low-rated (360 / 2,407 = 15.0%)
select count(*) from reviews
where rating <= 2
  and ("Review Text" like '%itchy%'
    or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%');

-- 2b: high-rated (779 / 18,208 = 4.3%)
select count(*) from reviews
where rating >= 4
  and ("Review Text" like '%itchy%'
    or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%');

-- 2c: Keyword check. I read 30 random low-rated matches; 24 were real fabric complaints (~80%).
-- The other 6 were armhole fit complaints, which is how I caught the armhole issue.
-- This is the original query before the fix.
-- After the fix, the fabric rate went from 17% to 15%.
select rating, "Review Text" from reviews
where rating <= 2
  and ("Review Text" like '%itchy%' or "Review Text" like '%holes%'
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%')
order by random()
limit 30;



-- Finding 3: Departments

-- Tops has the most bad reviews, but only because it's the largest department.
-- Most departments have around 8-11% bad reviews.
-- Trend has the highest rate (18.5%) but only 119 reviews.

-- 3a: Bad reviews per department (also the totals used in Finding 4)
select "Department Name", count(*), count("Review Text") from reviews
where rating <= 2
group by "Department Name"
order by count(*) desc;

-- 3b: All reviews per department
select "Department Name", count(*), count("Review Text") from reviews
group by "Department Name"
order by count(*) desc;



-- Finding 4: Fabric by Department

-- Jackets has the highest percentage of bad reviews that mention fabric problems (20%), but Tops has way more complaints overall (171).
-- Fixing Tops helps the most customers, but Jackets has the most concentrated problem.

-- 4a: Fabric complaints in bad reviews by department (divide by 3a for rates)
select "Department Name", count(*) from reviews
where rating <= 2
  and ("Review Text" like '%itchy%'
    or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%')
group by "Department Name"
order by count(*) desc;



-- Finding 5: Which Tops?

-- Within Tops, Sweaters have the highest fabric complaint rate in bad reviews (21%).
-- Happy sweater reviews also looked high at first (9.4%), but a sample group showed many were compliments like "not itchy." Keyword search can't tell the difference.
-- After adjusting for that, happy sweater reviews look normal, so the problem is specific to sweaters.

-- 5a: Fabric complaints in bad tops reviews by type
select "Class Name", count(*) from reviews
where rating <= 2 and "Department Name" = 'Tops'
  and ("Review Text" like '%itchy%'
    or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%')
group by "Class Name"
order by count(*) desc;

-- 5b: All bad Tops reviews, by type
select "Class Name", count(*) from reviews
where rating <= 2 and "Department Name" = 'Tops'
group by "Class Name"
order by count(*) desc;

-- 5c: Fabric complaints in happy Tops reviews, by type
select "Class Name", count(*) from reviews
where rating >= 4 and "Department Name" = 'Tops'
  and ("Review Text" like '%itchy%'
    or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%')
group by "Class Name"
order by count(*) desc;

-- 5d: All happy Tops reviews, by type
select "Class Name", count(*) from reviews
where rating >= 4 and "Department Name" = 'Tops'
group by "Class Name"
order by count(*) desc;

-- 5e: Read 20 random happy sweater matches; 8 were compliments like "not itchy"
select rating, "Review Text" from reviews
where rating >= 4 and "Department Name" = 'Tops' and "Class Name" = 'Sweaters'
  and ("Review Text" like '%itchy%'
    or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
    or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
    or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
    or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
    or "Review Text" like '%shrank%' or "Review Text" like '%pilling%')
order by random()
limit 20;



-- Finding 6: Recommendations

-- To check business impact, I looked at whether customers said they'd recommend the item (1 = yes, 0 = no).
-- Wouldn't recommend: 17.8% overall, 25.2% with sizing complaints, 39.6% with fabric complaints.
-- Fabric problems more than double the chance a customer won't recommend the item, while sizing has a smaller effect.
-- The real gap is likely larger, since some fabric matches are compliments like "not itchy."

-- 6a: All reviews (82.2% recommend)
select round(avg("Recommended IND") * 100, 1) as pct_recommend from reviews;

-- 6b: Fabric complaints (60.4% recommend)
select round(avg("Recommended IND") * 100, 1) as pct_recommend from reviews
where "Review Text" like '%itchy%'
   or ("Review Text" like '%holes%' and "Review Text" not like '%arm%hole%')
   or "Review Text" like '%poor quality%' or "Review Text" like '%cheap%'
   or "Review Text" like '%too thin%' or "Review Text" like '%so thin%'
   or "Review Text" like '%see through%' or "Review Text" like '%see-through%'
   or "Review Text" like '%shrank%' or "Review Text" like '%pilling%';

-- 6c: Sizing complaints (74.8% recommend)
select round(avg("Recommended IND") * 100, 1) as pct_recommend from reviews
where "Review Text" like '%too small%' or "Review Text" like '%runs small%'
   or "Review Text" like '%too big%' or "Review Text" like '%runs large%'
   or "Review Text" like '%arm%hole%';



-- Complaint Phrases
-- My list of complaint phrases (fabric or sizing), used to count each complaint in Finding 7.
drop table if exists complaint_phrases;
create table complaint_phrases (phrase text, category text);

insert into complaint_phrases values
('itchy', 'fabric'), ('holes', 'fabric'), ('poor quality', 'fabric'), ('cheap', 'fabric'),
('too thin', 'fabric'), ('so thin', 'fabric'), ('see through', 'fabric'), ('see-through', 'fabric'),
('shrank', 'fabric'), ('pilling', 'fabric'),
('too small', 'sizing'), ('runs small', 'sizing'), ('too big', 'sizing'), ('runs large', 'sizing'),
('arm%hole', 'sizing');



-- Finding 7: Top Complaints

-- Joined reviews to the phrase table to see which specific complaints are most common in bad reviews.
-- "Cheap" is the top complaint by far (173), followed by see-through (65, both spellings) and thin (31).
-- Damage like holes, pilling, and shrinking is much less common.
-- The main issue is items looking or feeling cheap and sheer, not falling apart.
-- For sizing, items running too big (98) came up a little more than items running too small (87), and armholes came up 71 times.
-- If a review mentions two phrases, it gets counted for both.

-- 7a: Phrase counts in bad reviews
select k.category, k.phrase, count(*) as num_reviews
from reviews r
join complaint_phrases k on r."Review Text" like '%' || k.phrase || '%'
where r.rating <= 2
  and not (k.phrase = 'holes' and r."Review Text" like '%arm%hole%')
group by k.category, k.phrase
order by num_reviews desc;

-- 7b: Checked "cheap" since it's the top result. All 20 random low-rated matches were real quality complaints.
select rating, "Review Text" from reviews
where rating <= 2 and "Review Text" like '%cheap%'
order by random()
limit 20;
