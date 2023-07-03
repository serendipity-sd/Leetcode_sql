-- use leetcode;

-- drop table if exists numbers;
-- Create table If Not Exists Numbers (
--        Number int, 
--        Frequency int);

-- Truncate table Numbers;
-- insert into Numbers (Number, Frequency) values ('0', '7');
-- insert into Numbers (Number, Frequency) values ('1', '1');
-- insert into Numbers (Number, Frequency) values ('2', '3');
-- insert into Numbers (Number, Frequency) values ('3', '1');

-- The Numbers table keeps the value of number and its frequency.

-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.

with recursive rec_cte as
(
  select num, frequency , 1 as cnt from Numbers
  union 
  select num, frequency , cnt + 1 from rec_cte 
  where cnt < frequency
  ), 
  med_cte as 
  (
    select num,  frequency, cnt , ROW_NUMBER() over(order by num) row_num, 
    count(*) over() tot_count
    from rec_cte
  )
select case when MOD(tot_count, 2) = 0 then round avg(num,1)
else round(num, 1) end as median
where row_num between
tot_count/2 and tot_count/2-1