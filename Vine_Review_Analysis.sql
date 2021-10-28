-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

select helpful_votes*100/total_votes as useful_ratio,* 
into #useful_reviews_w_vine
from vine_table v
where total_votes >= 20
	and vine = 'Y'
	and helpful_votes*100/total_votes>=50
;