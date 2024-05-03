/*

CLEAN.SQL FILE FOR SCRAPERS

Note: As of the current version, the scraper dumping tables mlbpre, and game_results are not being erased after piping clean data over to new
tables. This is to ensure everything runs correctly first. ON CONFLICT DO NOTHING is being used to ensure information is not duplicated.

*/


-- PRICES TABLE

WITH json_rows AS (
    SELECT 
        (raw_json ->> 'id')::TEXT AS game_id,
  			(raw_json ->> 'away_team')::TEXT AS away_team,
  			(raw_json ->> 'home_team')::TEXT AS home_team,
  			(raw_json ->> 'commence_time')::timestamp with time zone AT TIME ZONE 'PST' AS commence_time_pst,
        jsonb_array_elements(raw_json -> 'bookmakers') AS bookmaker
    FROM mlbpre
)
INSERT INTO prices
SELECT 
    game_id,
    commence_time_pst,
    away_team,
    home_team,
    (bookmaker ->> 'title')::text AS bookmaker,
    (bookmaker -> 'markets' -> 0 -> 'outcomes' -> 0 ->> 'name')::text AS team_name_1,
    (bookmaker -> 'markets' -> 0 -> 'outcomes' -> 0 ->> 'price')::numeric AS team_1_price,
    (bookmaker -> 'markets' -> 0 -> 'outcomes' -> 1 ->> 'name')::text AS team_name_2,
    (bookmaker -> 'markets' -> 0 -> 'outcomes' -> 1 ->> 'price')::numeric AS team_2_price
FROM json_rows
ON CONFLICT (game_id, bookmaker)
DO NOTHING
;


-- GAME KEY TABLE

INSERT INTO game_keys
SELECT 
		(raw_json ->> 'id')::TEXT AS game_id,
    (raw_json ->> 'commence_time')::timestamp with time zone AS commence_time,
    (raw_json ->> 'away_team')::TEXT AS away_team,        
    (raw_json ->> 'home_team')::TEXT AS home_team
FROM mlbpre
ON CONFLICT (game_id)
DO NOTHING
;

-- MLB GAMES TABLE

WITH json_rows AS (
    SELECT jsonb_array_elements(raw_json -> 'dates' -> 0 -> 'games') AS game
    FROM game_results
),
tran AS (
    SELECT json_build_object('game', game) AS game_data
    FROM json_rows
)
INSERT INTO mlb_games
SELECT
		gk.game_id,
    (game_data -> 'game' ->> 'officialDate')::date AS official_date,
    (game_data -> 'game' ->> 'gameDate')::timestamptz AT TIME ZONE 'UTC' AS game_time_stp,
    (game_data -> 'game' -> 'teams' -> 'away' -> 'team' ->> 'name') AS away_name,
    (game_data -> 'game' -> 'teams' -> 'away' ->> 'score')::int AS away_score,
    (game_data -> 'game' -> 'teams' -> 'home' -> 'team' ->> 'name') AS home_name,
    (game_data -> 'game' -> 'teams' -> 'home' ->> 'score')::int AS home_score,
    game_data -> 'game' -> 'status' ->> 'detailedState' AS game_state,
    game_data -> 'game' ->> 'dayNight' AS day_night,
    game_data -> 'game' ->> 'gameType' AS game_type,
    (game_data -> 'game' ->> 'gameNumber')::int AS game_number,
    game_data -> 'game' ->> 'description' AS description,
    (game_data -> 'game' -> 'venue' ->> 'name') AS venue_name
FROM 
    tran
INNER JOIN 
    game_keys AS gk ON (game_data -> 'game' -> 'teams' -> 'away' -> 'team' ->> 'name' = gk.away_team
                      AND game_data -> 'game' -> 'teams' -> 'home' -> 'team' ->> 'name' = gk.home_team
                      AND (game_data -> 'game' ->> 'gameDate')::timestamptz AT TIME ZONE 'UTC' = gk.commence_time)
WHERE 
    game_data -> 'game' -> 'status' ->> 'detailedState' = 'Final'
ON CONFLICT (game_id)
DO NOTHING
;

-- CREATING PROFITS TABLE

INSERT INTO mlb_games_split
SELECT game_id, official_date, home_name AS team_name,
       CASE WHEN home_score > away_score THEN TRUE ELSE FALSE END AS is_winner,
       game_type
FROM mlb_games
UNION ALL
SELECT game_id, official_date, away_name AS team_name,
       CASE WHEN away_score > home_score THEN TRUE ELSE FALSE END AS is_winner,
       game_type
FROM mlb_games
ORDER BY official_date
ON CONFLICT (game_id, team_name)
DO NOTHING
;

INSERT INTO prices_split
SELECT game_id, commence_time_pst, team_name_1 AS team_name, bookmaker, team_1_price AS price
FROM prices
UNION ALL
SELECT game_id, commence_time_pst, team_name_2 AS team_name, bookmaker, team_2_price AS price
FROM prices
ON CONFLICT (game_id, team_name, bookmaker)
DO NOTHING
;

INSERT INTO profits
SELECT
    mgs.game_id,
    mgs.team_name,
    mgs.is_winner,
    mgs.game_type,
    ps.bookmaker,
    ps.price
FROM
    mlb_games_split mgs
JOIN
    prices_split ps ON mgs.game_id = ps.game_id AND mgs.team_name = ps.team_name
ORDER BY game_id, team_name, bookmaker
ON CONFLICT (game_id, team_name, bookmaker)
DO NOTHING
;

UPDATE profits
SET winnings = CASE
    WHEN is_winner AND price < 0 THEN ((100.0 / ABS(price)) * 10)
    WHEN is_winner AND price >= 0 THEN (price / 100.0) * 10
    ELSE -10
END;

UPDATE profits
SET game_type = CASE 
                    WHEN game_type = 'R' THEN 'Regular Season'
                    WHEN game_type = 'S' THEN 'Spring Training'
                    ELSE game_type
                END;
