-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

select * into over20votes_table from vine_table
where total_votes >=20
;

select * into moreuseful_table from over20votes_table
where helpful_votes*100/total_votes>=50
；

--table1
select * into vinereview_table from moreuseful_table
where vine = 'Y'

--table2
select * into novinereview_table from moreuseful_table
where vine = 'N'

--table3
select
(select count(*) from vine_table) as Total_Vote_Count,
(select count(*) from vine_table where star_rating = 5) as "5-Star_Count",
cast(
	(select count(*) from vine_table 
		where star_rating = 5 and vine = 'Y') 
	as decimal)*100
	/
(select count(*) from vine_table 
	where vine = 'Y') 
as "5-Star_vine (%)",
cast((select count(*) from vine_table 
	  where star_rating = 5 and vine = 'N')
	 as decimal)*100/
	(select count(*) from vine_table where vine = 'N') as "5-Star_no_vine （%）"
;

/* 
--easy to do in 1 select for the first 2 tables, 
--but as the instruction requires, tables are created in each step. 
--below is a better conbined version.
select * 
into useful_reviews_w_vine
from vine_table v
where total_votes >= 20
	and vine = 'Y'
	and helpful_votes*100/total_votes>=50
;*/