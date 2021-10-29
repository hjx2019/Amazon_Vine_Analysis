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

--The total number of reviews, the number of 5-star reviews, 
--and the percentage 5-star reviews are calculated for all Vine 
--and non-Vine reviews (15 pt)
select
(select count(*) from moreuseful_table) as Total_Vote_Count,
(select count(*) from moreuseful_table where star_rating = 5) as "5-Star_Count",
cast(
	(select count(*) from vinereview_table 
		where star_rating = 5) 
	as decimal)*100
		/
	(select count(*) from vinereview_table) 
	as "5-Star_vine (%)",
cast((select count(*) from novinereview_table 
	  where star_rating = 5)
	 as decimal)*100/
	(select count(*) from novinereview_table) as "5-Star_no_vine （%）"
;

