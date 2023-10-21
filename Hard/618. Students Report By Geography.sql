-- Description
-- A U.S graduate school has students from Asia, Europe and America. The students’ location information are stored in table student as below.

-- | name   | continent |
-- |--------|-----------|
-- | Jack   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jane   | America   |
-- Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.

-- For the sample input, the output is:

-- | America | Asia | Europe |
-- |---------|------|--------|
-- | Jack    | Xi   | Pascal |
-- | Jane    |      |        |
-- Follow-up: If it is unknown which continent has the most students, can you write a query to generate the student report?

-- Write your MySQL query statement below
-- solution 1 - using session variable 
     
select America, Asia, Europe from
    (
        select @asia := 0, @america := 0, @europe := 0
    ) t,
    (
        select @asia := @asia + 1 as Asia_Id, name as Asia from student
            where continent = 'Asia' order by Asia
    ) t1
        right join
    (
        select @america := @america + 1 as America_Id, name as America from student
            where continent = 'America' order by America
    ) t2 on Asia_Id = America_Id
        left join
    (
        select @europe := @europe + 1 as Europe_Id, name as Europe from student
            where continent = 'Europe' order by Europe
    ) t3 on America_Id = Europe_Id
;

-- solution 2
select america , europe, asia from
(select row_number() over(order by name)euid, name as Europe from student
where continent = 'Europe') eu
right join
(select row_number() over(order by name)amid, name as Europe from student
where continent = 'Europe') am
on euid = amid
left join
(select row_number() over(order by name)asid, name as Europe from student
where continent = 'Europe') Asia