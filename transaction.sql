/* change species to unspecified and rollback */
BEGIN;
COMMIT;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
END;

/* set animals with mon to digimon */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
COMMIT;
END;

/* set pokemon for all null */
BEGIN;
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
END;


/* delete all animals and rollback*/
BEGIN;
DELETE from animals *;
SELECT * from animals;
ROLLBACK;
END;

SELECT * from animals; /* making sure all data still exist */

/* delete animals born after Jan 1st, 2022*/
BEGIN;
DELETE from animals where date_of_birth >= '2022-01-01';
COMMIT;
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * - 1;
ROLLBACK SP1;
UPDATE animals SET weight_kg = weight_kg * - 1 where weight_kg < 0;
COMMIT;
END;
