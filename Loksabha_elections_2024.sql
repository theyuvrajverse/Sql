use new_schema;
select * from constituencywise_details;
select * from constituencywise_results;
select * from partywise_results;
select * from states;
select * from statewise_results;
use new_schema;
#select count(Parliament_Constituency) from constituencywise_results;
#select max(total_votes) from constituencywise_results;
#SHOW COLUMNS FROM constituencywise_results;
#SELECT COUNT(*) 
#FROM constituencywise_results;
#SELECT COUNT(`Parliament_Constituency`) 
#FROM constituencywise_results;

#SELECT COUNT(`Parliament_Constituency`) 
#FROM constituencywise_results;

SELECT COUNT(DISTINCT `Parliament Constituency`) 
FROM constituencywise_results;
SELECT COUNT(DISTINCT `Parliament Constituency`) as total_seats
FROM constituencywise_results;

SELECT DISTINCT `Parliament Constituency` 
FROM constituencywise_results;

SELECT `Parliament Constituency`, COUNT(*) as Total_Count
FROM constituencywise_results
GROUP BY `Parliament Constituency`;

-- What is the total number of seats available for elections in each state
select s.state as  state_name,
count(cr.parliament_constituency) as total_Seats
from constituencywise_results cr
inner join statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
inner join states s on sr.state_id = s.state_id
group by s.state;

-- SELECT s.state AS state_name,
-- COUNT(cr.`Parliament Constituency`) AS total_Seats
--  FROM constituencywise_results cr
-- INNER JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
-- iNNER JOIN states s ON sr.state_id = s.state_id
-- GROUP BY s.state
-- ORDER BY total_Seats DESC;
-- SHOW COLUMNS FROM statewise_results;
-- SHOW COLUMNS FROM states;

SELECT s.state AS state_name,
COUNT(cr.`Parliament Constituency`) AS total_Seats
FROM constituencywise_results cr
INNER JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
INNER JOIN states s ON sr.`State ID` = s.`State ID`
GROUP BY s.state
ORDER BY total_Seats DESC;

# Total seats won by NDA alliance
-- SELECT 
   --  SUM(CASE 
      --       WHEN party IN (
     --            'Bharatiya Janata Party - BJP', 
  --               'Telugu Desam - TDP', 
-- 				'Janata Dal  (United) - JD(U)',
--                 'Shiv Sena - SHS', 
 --               'AJSU Party - AJSUP', 
   --             'Apna Dal (Soneylal) - ADAL', 
--                'Asom Gana Parishad - AGP',
  --              'Hindustani Awam Morcha (Secular) - HAMS', 
    --            'Janasena Party - JnP', 
		--		'Janata Dal  (Secular) - JD(S)',
          --      'Lok Janshakti Party(Ram Vilas) - LJPRV', 
--                'Nationalist Congress Party - NCP',
  --              'Rashtriya Lok Dal - RLD', 
    --            'Sikkim Krantikari Morcha - SKM'
      --      ) THEN [Won]
        --    ELSE 0 
 --       END) AS NDA_Total_Seats_Won
-- FROM 
   -- partywise_results
SELECT
    SUM(CASE
            WHEN party IN (
                'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM'
            ) THEN Won
            ELSE 0
        END) AS NDA_Total_Seats_Won
FROM
    partywise_results;
    
SELECT 
    party as party_name,
    Won AS Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP',
        'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY 
    Won DESC;
    
# Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
-- Step 1: Add the new column
ALTER TABLE partywise_results
ADD party_alliance1 VARCHAR(50);

-- Step 2: Update I.N.D.I.A Alliance parties
UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',  
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

-- Step 3: Update NDA Alliance parties
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

-- Step 4: Update remaining parties as OTHER
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

ALTER TABLE partywise_results
DROP COLUMN party_alliance1;

select party_alliance, sum(Won) from partywise_results group by party_alliance;
select party, won from partywise_results where party_alliance = 'I.N.D.I.A' order by won desc;

# Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
-- SELECT cr.Winning_Candidate, p.Party, p.party_alliance, cr.Total_Votes, cr.Margin, cr.Constituency_Name, s.State
-- FROM constituencywise_results cr
-- JOIN partywise_results p ON cr.Party_ID = p.Party_ID
-- JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
-- JOIN states s ON sr.State_ID = s.State_ID
-- WHERE s.State = 'Uttar Pradesh' AND cr.Constituency_Name = 'AMETHI';
SELECT 
    cr.`Winning Candidate`, 
    p.Party, 
    p.party_alliance, 
    cr.`Total Votes`, 
    cr.Margin, 
    cr.`Constituency Name`, 
    s.State
FROM constituencywise_results cr
JOIN partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN states s ON sr.`State ID` = s.`State ID`
WHERE s.State = 'Uttar Pradesh' AND cr.`Constituency Name` = 'AMETHI';

# What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
SELECT
    cd.Candidate,
    cd.Party,
    cd.`EVM Votes`,
    cd.`Postal Votes`,
    cd.`Total Votes`,
    cr.`Constituency Name`
FROM constituencywise_details cd
JOIN constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE cr.`Constituency Name` = 'AMROHA'
ORDER BY cd.`Total Votes` DESC;

#Which parties won the most seats in s State, and how many seats did each party win?
SELECT 
    p.Party,
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN 
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN states s ON sr.`State ID` = s.`State ID`
WHERE 
    s.state = 'Andhra Pradesh'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;

#What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN 
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN 
    states s ON sr.`State ID` = s.`State ID`
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
    s.State
ORDER BY 
    s.State;
    
# Which candidate received the highest number of EVM votes in each constituency (Top 10)?
SELECT
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.Candidate,
    cd.`EVM Votes`
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE 
    cd.`EVM Votes` = (
        SELECT MAX(cd1.`EVM Votes`)
        FROM constituencywise_details cd1
        WHERE cd1.`Constituency ID` = cd.`Constituency ID`
    )
ORDER BY 
    cd.`EVM Votes` DESC
    limit 10; #TOP10 NOW
    
# Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
WITH RankedCandidates AS (
    SELECT
        cd.`Constituency ID`,
        cd.Candidate,
        cd.Party,
        cd.`EVM Votes`,
        cd.`Postal Votes`,
        cd.`EVM Votes` + cd.`Postal Votes` AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.`Constituency ID` ORDER BY cd.`EVM Votes` + cd.`Postal Votes` DESC) AS VoteRank
    FROM
        constituencywise_details cd
    JOIN
        constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
    JOIN
        statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
    JOIN
        states s ON sr.`State ID` = s.`State ID`
    WHERE
        s.State = 'Maharashtra'
)
SELECT
    cr.`Constituency Name`,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM
    RankedCandidates rc
JOIN
    constituencywise_results cr ON rc.`Constituency ID` = cr.`Constituency ID`
GROUP BY
    cr.`Constituency Name`
ORDER BY
    cr.`Constituency Name`;

# For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
SELECT 
    COUNT(DISTINCT cr.`Constituency ID`) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.`EVM Votes` + cd.`Postal Votes`) AS Total_Votes,
    SUM(cd.`EVM Votes`) AS Total_EVM_Votes,
    SUM(cd.`Postal Votes`) AS Total_Postal_Votes
FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.`Constituency ID` = cd.`Constituency ID`
JOIN 
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
JOIN 
    states s ON sr.`State ID` = s.`State ID`
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
WHERE 
    s.State = 'Maharashtra';
