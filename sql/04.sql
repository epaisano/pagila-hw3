/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
select distinct t.first_name, t.last_name
FROM
(select first_name, last_name
from
    actor
JOIN
    film_actor USING(actor_id)
JOIN
    film USING(film_id)
JOIN
    film_category USING(film_id)
JOIN
    category USING(category_id)
WHERE
  category.name = 'Children') as t
left join 
(select first_name, last_name
FROM
    actor
JOIN
    film_actor USING(actor_id)
JOIN
    film USING(film_id)
JOIN
    film_category USING(film_id)
JOIN
    category USING(category_id)
WHERE
    category.name = 'Horror') as y
on t.first_name=y.first_name and t.last_name=y.last_name
where y.first_name is null and y.last_name is null
order by t.last_name, t.first_name;
