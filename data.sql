/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-09-15', 2, true, 8.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2022-02-02', 0, false, -11.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2022-09-15', 2, true, -5.70);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, -45.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 20.40);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17.00);

-- Insert into owners table
INSERT INTO owners (full_name, age) 
  VALUES ('Sam Smith', 34),
        ('Jennifer', 19),
        ('Bob', 45),
        ('Melody Pond', 77),
        ('Dean Winchester', 14),
        ('Jodie Whittaker', 38);

-- Insert into species table
INSERT INTO species (name)
  VALUES ('Pokemon'),
        ('Digimon');

-- set species-id for name ends in "mon"
BEGIN;
UPDATE animals
SET species_id = 1 WHERE name LIKE '%mon'; -- Digimon
COMMIT;

-- set poke
BEGIN;
UPDATE animals
SET species_id = 2 WHERE species_id is NULL;
COMMIT;


-- Modify your inserted animals to include owner information (owner_id):
BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')  WHERE name='Agumon';
COMMIT;

BEGIN;
UPDATE animals
SET owners_id = (SELECT id FROM owners WHERE full_name='Jennifer Orwell') WHERE name='Gabumon' OR name='Pikachu';
COMMIT;

BEGIN;
UPDATE animals
SET owners_id= (SELECT id FROM owners WHERE full_name='Bob') WHERE name='Devimon' OR name='Plantmon';
COMMIT;

BEGIN;
UPDATE animals
SET owners_id= (SELECT id FROM owners WHERE full_name='Melody Pond') WHERE name='Charmander' OR name='Squirtle' OR name='Blossom';
COMMIT;

BEGIN;
UPDATE animals
SET owners_id= (SELECT id FROM owners WHERE full_name='Dean Winchester') WHERE name='Angemon' OR name='Boarmon';
COMMIT;

-- Insert into vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Insert into specializations table
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), 2);

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), 3);

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), 1);

-- insert into visit table
INSERT INTO visits (vets_id, animals_id, visit_date)
VALUES
    ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id from animals where name = 'Agumon'),'2020-05-24'),
    ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id from animals where name = 'Agumon'),'2020-07-22'),
    ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id from animals where name = 'Gabumon'),'2021-02-02'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Pikachu'),'2020-01-05'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Pikachu'),'2020-03-08'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Pikachu'),'2020-05-14'),
    ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id from animals where name = 'Devimon'),'2021-05-04'),
    ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id from animals where name = 'Charmander'),'2021-02-24'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Plantmon'),'2019-12-21'),
    ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id from animals where name = 'Plantmon'),'2020-08-10'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Plantmon'),'2021-04-07'),
    ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id from animals where name = 'Squirtle'),'2019-09-29'),
    ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id from animals where name = 'Angemon'),'2020-10-03'),
    ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id from animals where name = 'Angemon'),'2020-11-04'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Boarmon'),'2019-01-24'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Boarmon'),'2019-05-15'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Boarmon'),'2020-02-27'),
    ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id from animals where name = 'Boarmon'),'2020-08-03'),
    ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id from animals where name = 'Blossom'),'2020-05-24'),
    ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id from animals where name = 'Blossom'),'2021-01-11');
