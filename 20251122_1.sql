# поиск дат, для которых сумма времени больше чем максимальное время на эту дату
SELECT 
    `time`, time(SUM(`data`))
FROM
    `group` `outer`
GROUP BY `time`
HAVING SUM(`data`) = (SELECT 
        MAX(`data`)
    FROM
        `group` `inner`
    WHERE
        `outer`.`time` = `inner`.`time`);

# Поиск тех ролей, которые относятся к имени игрока, так чтобы игрок с таким именем был танком
SELECT 
    `name`, `role`
FROM
    gamer `outer`
WHERE
    `name` IN (SELECT 
            `name`
        FROM
            gamer `inner`
        WHERE
            `outer`.`role` = `inner`.`role`  = 'tank');

# поиск количества ролей на уровень так чтобы среди ролей был танк
            
SELECT 
    `level`, COUNT(`role`)
FROM
    gamer
GROUP BY `level`
HAVING `level` < (SELECT 
        AVG(`level`)
    FROM
        gamer
    WHERE
        `role` = 'tank');