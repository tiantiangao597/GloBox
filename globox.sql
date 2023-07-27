SELECT
  u.id AS id,
  Coalesce(u.country, 'NA') AS country,
  Coalesce(u.gender, 'NA') AS gender,
  (
    CASE
      WHEN g.device = 'I' THEN 'IOS'
      WHEN g.device = 'A' THEN 'Android'
      ELSE 'NA'
    END
  ) AS device,
  g.group AS group,
  (
    CASE
      WHEN SUM(Coalesce(a.spent, 0)) > 0 then 1
      ELSE 0
    END
  ) AS converted,
  CAST(SUM(Coalesce(a.spent, 0)) AS DECIMAL(10, 2)) AS total_spent
FROM
  users as u
  LEFT JOIN groups as g ON u.id = g.uid
  LEFT JOIN activity as a ON u.id = a.uid
GROUP BY
  u.id,
  u.country,
  u.gender,
  g.device,
  g.group
;
