/*
Joseph Leong
V00835877
APR 8 2016
*/


drop table if exists marathon2016;
.read victoria_marathon_2016.sql

--This file was used primarly to extract the data from the victoria_marathon_2016.sql and convert to a csv.file

/*
.header on
.mode csv
.output marathon.csv
select * from marathon2016;
*/

--Code under here was used to try and achive the same table subsets as R.studio

---
.header on
.mode column
---

--find frequency distribution of participants by hometown
select distinct hometown, count(hometown) 
    from marathon2016 
    group by hometown
    order by count(hometown) DESC;

--find frequncy distribtuion by Division
select distinct division, count(division) 
    from marathon2016 
    group by division
    order by count(division) DESC;

-- find men divisions counts
select distinct division, count(division) 
    from marathon2016 
    where division = "M01-19" or division = "M20-24" or division = "M20-24" or division = "M25-29" 
        or division = "M30-34" or division = "M35-39" or division = "M40-44" or division = "M45-49" 
        or division = "M50-54" or division = "M54-59" or division = "M60-64" or division = "M65-69"
        or division = "M70-74" or division = "M75-79" or division = "M80-99" 
    group by division   
    order by division;

-- find woman divisions counts
select distinct division, count(division) 
    from marathon2016 
    where division = "F01-19" or division = "F20-24" or division = "F20-24" or division = "F25-29" 
        or division = "F30-34" or division = "F35-39" or division = "F40-44" or division = "F45-49" 
        or division = "F50-54" or division = "F54-59" or division = "F60-64" or division = "F65-69"
        or division = "F70-74" or division = "F75-79" 
    group by division   
    order by division;

-- Find 20 of the fastest times
select name, total_seconds 
    from marathon2016
    group by total_seconds
    order by total_seconds ASC Limit 20;

-- Find 20 of the Slowest times
select name, total_seconds 
    from marathon2016
    group by total_seconds
    order by total_seconds DESC Limit 20;

--Find 20 of the Fastest Men
select name, total_seconds 
    from marathon2016
     where division = "M01-19" or division = "M20-24" or division = "M20-24" or division = "M25-29" 
        or division = "M30-34" or division = "M35-39" or division = "M40-44" or division = "M45-49" 
        or division = "M50-54" or division = "M54-59" or division = "M60-64" or division = "M65-69"
        or division = "M70-74" or division = "M75-79" or division = "M80-99" 
    group by total_seconds
    order by total_seconds ASC Limit 20;

-- find 20 of the Slowest Men
select name, total_seconds 
    from marathon2016
     where division = "M01-19" or division = "M20-24" or division = "M20-24" or division = "M25-29" 
        or division = "M30-34" or division = "M35-39" or division = "M40-44" or division = "M45-49" 
        or division = "M50-54" or division = "M54-59" or division = "M60-64" or division = "M65-69"
        or division = "M70-74" or division = "M75-79" or division = "M80-99" 
    group by total_seconds
    order by total_seconds DESC Limit 20;

--Find 20 of the Fastest Women
select name, total_seconds 
    from marathon2016
     where division = "F01-19" or division = "F20-24" or division = "F20-24" or division = "F25-29" 
        or division = "F30-34" or division = "F35-39" or division = "F40-44" or division = "F45-49" 
        or division = "F50-54" or division = "F54-59" or division = "F60-64" or division = "F65-69"
        or division = "F70-74" or division = "F75-79" 
    group by total_seconds
    order by total_seconds ASC Limit 20;

-- find 20 of the Slowest Women
select name, total_seconds 
    from marathon2016
     where division = "F01-19" or division = "F20-24" or division = "F20-24" or division = "F25-29" 
        or division = "F30-34" or division = "F35-39" or division = "F40-44" or division = "F45-49" 
        or division = "F50-54" or division = "F54-59" or division = "F60-64" or division = "F65-69"
        or division = "F70-74" or division = "F75-79"  
    group by total_seconds
    order by total_seconds DESC Limit 20;
---
.output stdout
.print ""
.print "end of file"