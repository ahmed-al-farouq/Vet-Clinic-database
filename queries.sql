/* Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name from animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg>10.5;
SELECT name from animals where neutered=TRUE;
SELECT name from animals where weight_kg BETWEEN 10.4 AND 17.3;

-- Number of all animals
SELECT COUNT(name) from animals;

-- animals tries to scape
SELECT COUNT(name) from animals where escape_attempts > 0;

-- average weight
SELECT AVG(weight_kg) from animals;

-- escaped the most
SELECT name from animals WHERE escape_attempts = (select MAX(escape_attempts) from animals);

-- min, max weight for each type
SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;

-- average scapes between 1990 and 2000
SELECT species, AVG(escape_attempts) from animals where date_of_birth BETWEEN '1990-1-1' AND '2000-1-1' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON owners.id = animals.owners_id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon.
SELECT name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

-- How many animals are there per species?
SELECT species.name, count( animals.species_id ) FROM species JOIN animals ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT animals.name FROM species JOIN animals ON animals.species_id = species.id JOIN owners ON owners.id = animals.owners_id WHERE owners.full_name='Jennifer Orwell' AND species.name='Pokemon';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT name FROM animals JOIN owners ON owners.id = animals.owners_id WHERE owners.full_name='Dean Winchester' AND  animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name FROM animals JOIN owners ON owners.id = animals.owners_id GROUP BY owners.full_name ORDER BY count(name) DESC LIMIT 1;

--  last seen animal by william 
SELECT animals.name FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id WHERE vets.name='William Tatcher' ORDER BY visit_date DESC FETCH FIRST ROW ONLY;

--  How many animals did stephanie see 
SELECT count(animals.name) FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id WHERE vets.name='Stephanie Mendez';

--  list vets and their speciality (including ones who hasn't) 
SELECT vets.name , species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON species.id=specializations.species_id;

--  animals that visited stephanie between 01/04/2020 and 30/08/2002 
SELECT animals.name FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id WHERE vets.name='Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

--  animal who had the most visits to vets 
SELECT animals.name FROM animals JOIN visits ON animals.id=visits.animals_id GROUP BY animals.name ORDER BY count( animals.name ) DESC FETCH FIRST ROW ONLY;

--  first visit to maisy
SELECT animals.name, visits.visit_date FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id WHERE vets.name='Maisy Smith'
ORDER BY visit_date FETCH FIRST ROW ONLY;

--  details on latest visit  
SELECT visits.visit_date animals.*, vets.name, vets.age, vets.date_of_graduation FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id
ORDER BY visit_date DESC FETCH FIRST ROW ONLY;

--  visists with vet that has no speciality 
SELECT count(animals.name), vets.name FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id LEFT JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id IS NULL GROUP BY vets.name;

--  Speciality that Maisy should take considering the amount of vists she had
SELECT species.name FROM vets JOIN visits ON visits.vets_id=vets.id JOIN animals ON visits.animals_id=animals.id
JOIN species ON animals.species_id=species.id WHERE vets.name='Maisy Smith'
GROUP BY species.name ORDER BY COUNT(species.name) DESC LIMIT 1;
