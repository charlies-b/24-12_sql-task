-- create a tables
CREATE TABLE Audience (
  event_id TEXT PRIMARY KEY,
  users_id TEXT NOT NULL,
  Date TIMESTAMP NOT NULL,
  episode_id TEXT,
  content_type TEXT,
  play_time INTEGER,
  episode_length INTEGER
);

CREATE TABLE Demographic (
    Age INTEGER,
    users_id TEXT PRIMARY KEY,
    Region TEXT
);

-- insert values
INSERT INTO Audience VALUES ('iqeq4x84r6x2yxl' , 'xw8EF' , '2016-08-25T08:15:30-05:00' , 'woaqa01' , 'vod' , 180 , 200);
INSERT INTO Audience VALUES ('iqeujzl76pff8hu' , 'IfTI1' , '2016-08-25T08:16:31-05:00' , 'eodjdm02' , 'vod' , 260 , 300);
INSERT INTO Audience VALUES ('iqfnedekranvo17' , 'LiKkg' , '2016-08-25T08:15:35-05:00' , 'ddhdk02' , 'vod' , 360 , 500);
INSERT INTO Audience VALUES ('iqf9z35v5qxhsky' , 'LiF7q' , '2016-08-25T08:15:39-05:00' , 'endoep03' , 'live' , 700 , 720);
INSERT INTO Audience VALUES ('iqf6dth7il4ta0m' , 'Li9IS' , '2016-08-25T08:15:30-05:00' , 'wneola02' , 'live' , 80 , 1450);
INSERT INTO Audience VALUES ('iqfn8x5urtl1s98' , 'LhTcE' , '2016-08-25T08:17:30-05:00' , 'Wjdjdkdk02' , 'vod' , 190 , 300);
INSERT INTO Audience VALUES ('iqerdwmt2u3bb1n' , 'KuFh7' , '2016-08-25T08:17:43-05:00' , 'UddhdS01' , 'live' , 1000 , 1100);
INSERT INTO Audience VALUES ('iqg0u88i82wlr1i' , 'Kokho' , '2016-08-25T08:15:54-05:00' , 'oensksl02' , 'vod' , 389 , 400);

INSERT INTO Demographic VALUES ('25' , 'xw8EF' , 'North West');
INSERT INTO Demographic VALUES ('30' , 'IfTI1' , 'London');
INSERT INTO Demographic VALUES ('45' , 'LiKkg' , 'South West');
INSERT INTO Demographic VALUES ('51' , 'LiF7q' , 'Norh Wales');
INSERT INTO Demographic VALUES ('40' , 'Li9IS' , 'Scotland');
INSERT INTO Demographic VALUES ('60' , 'LhTcE' , 'London');
INSERT INTO Demographic VALUES ('47' , 'GgeoR' , 'North East');

-- SELECT completion rate by content_type
ALTER TABLE Audience ADD percent_watched AS (CAST(play_time AS float) / CAST(episode_length AS float));
ALTER TABLE Audience ADD complete AS (percent_watched>=0.90); -- define complete; here 90% watched or more for example

SELECT content_type as 'content_type', ROUND(AVG(complete),2) as 'completion_rate'
    FROM Audience 
    GROUP BY content_type;

-- SELECT average play_time by age group
ALTER TABLE Demographic ADD age_group AS (CASE
    WHEN (25<=age)&(age<=34) THEN '25-34'
    WHEN (35<=age)&(age<=44) THEN '35-44'
    WHEN (45<=age)&(age<=54) THEN '45-54'
    WHEN (55<=age) THEN '55+'
    ELSE NULL
END);
    
SELECT IFNULL(Demographic.age_group,'Unknown'), AVG(Audience.play_time)
    FROM Audience 
    LEFT JOIN Demographic 
    ON Audience.users_id = Demographic.users_id
    GROUP BY Demographic.age_group;