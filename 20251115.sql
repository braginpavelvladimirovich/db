#Различные соединения таблиц
#Выборка всех игр, которые находятся в разделе "Любимые" у нескольких пользователей
SELECT 
    game_name as 'Любимая игра'
FROM
    gamers a,
    games,
    gamers b
WHERE
    a.favorite_game = b.favorite_game
        AND a.favorite_game = idgame and a.`name`<b.`name`;

#Выборка всех игр, которые находятся в разделе "Любимые" у любых пользователей
SELECT 
    `games`.`game_name`, `gamers`.`name`
FROM
    `games`,
    `gamers`
WHERE
    `gamers`.`favorite_game` = `games`.`idgame`
ORDER BY game_name;

#Оператор JOIN
SELECT 
    *
FROM
    gamers
        JOIN
    gamers_games USING (idgamers);
#"Левое" и "правое" соединение
SELECT 
    *
FROM
    games
        LEFT JOIN
    gamers USING (country);
    
    SELECT DISTINCT
    country
FROM
    games
        RIGHT JOIN
    gamers USING (country);
#Внутреннее соединение
SELECT DISTINCT
    *
FROM
    games
        INNER JOIN
    gamers USING (country);
SELECT DISTINCT
    *
FROM
    games
        CROSS JOIN
    gamers USING (country);
# Соединение JOIN при помощи ON   
SELECT 
    *
FROM
    games
        JOIN
    gamers_games ON idgame = game
order by game_name;

#Таблица с циклическими зависимостями. Соединение таблицы с собой
SELECT 
	t1.`сотрудник` as начальник, 'над', t2.`сотрудник` подчинённый 
FROM 	20251025.`сотрудники` t1 
		LEFT JOIN
		20251025.`сотрудники` t2 ON t1.`ид_сотрудника` = t2.`номер_начальника`;
SELECT 
	t1.`сотрудник` as начальник, 'над', t2.`сотрудник` подчинённый 
FROM 	20251025.`сотрудники` t1 
		RIGHT JOIN
		20251025.`сотрудники` t2 ON t1.`ид_сотрудника` = t2.`номер_начальника`;
#"Естественное соединение" при помощи NATURAL JOIN
SELECT 
    `name`, `date`, `game_name`
FROM
    gamers
        NATURAL JOIN
    gamers_games
        NATURAL JOIN
    games;
/*
, `game_name`
JOIN
    games ON (gamers_games.idgame)
*/    
#При совпадении названий внешних ключей в связанных таблицах с первичными ключами можно использовать JOIN ON
/* Нерабочий запрос 
SELECT 
    *
FROM
    gamers_games
        JOIN
    gamers using on (idgamers);
*/

SELECT 
    *
FROM
    gamer
        NATURAL JOIN
    gamer_has_group
        NATURAL JOIN
    tank;
SELECT 
    *
FROM
    gamer
        NATURAL JOIN
    tank;
SELECT 
    *
FROM
    gamer
        CROSS JOIN
    tank;
SELECT 
    *
FROM
    gamer
        JOIN
    tank;
SELECT 
    *
FROM
    `20250930`.`gamer`
        RIGHT JOIN
    `20250930`.`gamer_has_group` on `gamer`.`group_grid` = `gamer_has_group`.`group_grid`;
SELECT 
    *
FROM
    `20250930`.`gamer`
        LEFT JOIN
    `20250930`.`gamer_has_group` ON `gamer`.`group_grid` = `gamer_has_group`.`group_grid`;
/* вывод игроков-лидеров имеющих группу по ид группы где ид группы больше 1 и ид игрока больше 0 и цель группы больше 1
вывод информации без пустых ячеек и где ид игрока совпадает */

SELECT 
    `gamer`.`name`,`gamer`.`role`,`gamer`.`level`
FROM
    `20250930`.`gamer`
        RIGHT JOIN
    `20250930`.`gamer_has_group` ON `gamer`.`group_grid` = `gamer_has_group`.`group_grid`
        AND `gamer_has_group`.`group_grid` > 1
        AND `gamer`.`gid` > 0
        AND `gamer`.`target_tid` > 1
WHERE
    `gamer`.`gid` IS NOT NULL
        AND `gamer`.`gid` = `gamer_has_group`.`gamer_gid`
        AND `gamer`.`leader` IS TRUE;