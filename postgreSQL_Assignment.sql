-- Active: 1747481936766@@localhost@5432@conservation_db

--- RANGERS TABLE
CREATE TABLE rangers (
      ranger_id SERIAL PRIMARY KEY,
      name VARCHAR(60) NOT NULL,
      region VARCHAR(60)
);
INSERT INTO rangers (name, region) 
      VALUES('Alice Green', 'Northern Hills'),
      ('Bob White', 'River Delta'),
      ('Carol King', 'Mountain Range'),
      ('David Black', 'Sunset Valley'),
      ('Emma Stone', 'Redwood Forest'),
      ('Frank Moore', 'Pine Ridge'),
      ('Grace Lee', 'Silver Lake'),
      ('Henry Adams', 'Cedar Grove'),
      ('Ivy Clark', 'Maple Plains'),
      ('Jack Hill', 'Bluewater Bay');
SELECT * FROM rangers;

--- SPECIES TABLE
CREATE TABLE species (
      species_id SERIAL PRIMARY KEY,
      common_name VARCHAR(80),
      scientific_name VARCHAR(90),
      discovery_date DATE,
      conservation_status VARCHAR(40)
);
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) 
      VALUES ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
      ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
      ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
      ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
      ('Indian Cobra', 'Naja naja', '1768-01-01', 'Least Concern'),
      ('Great Hornbill', 'Buceros bicornis', '1758-01-01', 'Vulnerable'),
      ('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
      ('Gaur', 'Bos gaurus', '1827-01-01', 'Vulnerable'),
      ('King Cobra', 'Ophiophagus hannah', '1836-01-01', 'Vulnerable'),
      ('Malabar Civet', 'Viverra civettina', '1821-01-01', 'Critically Endangered');
SELECT * FROM species;

--- SIGHTINGS TABLE
CREATE TABLE sightings (
      sighting_id SERIAL PRIMARY KEY,
      species_id INT REFERENCES species(species_id) ON DELETE CASCADE,
      ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
      location VARCHAR(110),
      sighting_time TIMESTAMP,
      notes TEXT
);
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
      VALUES  (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
      (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
      (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
      (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
      (4, 4, 'Sunset Valley', '2024-05-20 14:00:00', 'Herd spotted near water'),
      (8, 5, 'Redwood Forest', '2024-05-22 11:15:00', 'Single adult observed'),
      (6, 6, 'Pine Ridge', '2024-05-25 17:45:00', 'Pair flying overhead'),
      (2, 5, 'Silver Lake', '2024-05-27 08:30:00', 'Tracks found nearby'),
      (9, 1, 'Cedar Grove', '2024-05-29 13:10:00', 'Group grazing'),
      (8, 4, 'Maple Plains', '2024-06-01 19:05:00', 'Sighting after dusk');
SELECT * FROM sightings;


-- Problem 1
INSERT INTO rangers(name, region) VALUES('Darek Fox', 'Coastal Plains');


-- Problem 2
SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings;


-- Problem 3
SELECT * FROM sightings
      WHERE location ILIKE '%pass%';


-- Problem 4
SELECT r.name, COUNT(s.sighting_id) as total_sightings FROM rangers r
      JOIN sightings s ON r.ranger_id = s.ranger_id
            GROUP BY r.ranger_id, r.name  
                  ORDER BY r.name;


--- Problem 5
SELECT si.common_name FROM species si
      LEFT JOIN sightings s ON si.species_id = s.species_id
            WHERE s.species_id IS NULL;


--- Problem 6
SELECT common_name, si.sighting_time, r.name FROM sightings si
      JOIN species sp ON sp.species_id = si.species_id
      JOIN rangers r ON r.ranger_id = si.ranger_id  
      ORDER BY sighting_time DESC LIMIT 2;


--- Problem 7
UPDATE species
      SET conservation_status = 'Historic'
            WHERE discovery_date <  '1800-01-01';


--- Problem 8
SELECT sighting_id, 
      CASE
            WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 and 17 THEN 'Afternoon'
      ELSE 'Evening'
            END as time_of_day
      FROM sightings ORDER BY sighting_id;


--- Problem 9
DELETE FROM rangers
      WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings);
