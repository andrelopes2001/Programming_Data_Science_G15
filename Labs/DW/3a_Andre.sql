SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(DISTINCT film_id) AS nr
FROM
    actor,
    cast
WHERE
    actor.actor_id = cast.actor_id
GROUP BY cast.actor_id
ORDER BY nr DESC
LIMIT 1;