/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN DATE '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts > 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT  * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Database Transactions */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is null;
COMMIT

BEGIN
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint_1;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO savepoint_1;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT;

/*Query questions*/
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT name FROM animals ORDER BY escape_attempts DESC LIMIT 1;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'  GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name AS "name of animal",
full_name AS "full_name of owner"
FROM animals 
INNER  JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name AS "name of animal",
species.name AS "species name"
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name AS "full_name of owner",
animals.name AS "name of animal"
FROM animals 
FULL OUTER  JOIN owners
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(animals.name) AS "Animals Count", species.name AS "Species"
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name AS "full_name of owner",
animals.name AS "name of animal",
species.name AS "species"
FROM owners
INNER JOIN animals
ON animals.owner_id = owners.id
INNER JOIN species
ON animals.species_id = species_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name AS "full_name of owner",
animals.name AS "name of animal",
animals.escape_attempts
FROM owners
INNER JOIN animals
ON owners.id = animals.owner_id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT owners.full_name , COUNT(*)
FROM owners
INNER JOIN animals
ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT vets.name AS "vet name", animals.name AS "animal", visits.date_of_visit
FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER by date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name AS "vet name", COUNT(DISTINCT animals.name)
FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
 GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS "vet name",
species.name AS "specialities"
FROM vets
FULL OUTER JOIN specializations
ON vets.id = specializations.vet_id
FULL OUTER JOIN species
ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS "animals",
visits.date_of_visit
FROM animals
INNER JOIN visits
ON visits.animal_id = animals.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez')
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS "animal",
COUNT (*)
FROM animals
INNER JOIN visits
ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY count DESC LIMIT 1;


-- Who was Maisy Smith's first visit?
SELECT vets.name AS "vet name",
animals.name AS "animals",
visits.date_of_visit
FROM vets
INNER JOIN visits
ON visits.vet_id = vets.id
INNER JOIN animals
ON animals.id = visits.animal_id
WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Maisy Smith')
ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT vets.id AS "vet id",
vets.name AS "vet name",
date_of_graduation,
visits.date_of_visit,
animals.id AS "animal id",
animals.name AS "animal",
date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id
FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals
ON visits.animal_id = animals.id
ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name
FROM vets
JOIN visits
ON vets.id = visits.vet_id
LEFT JOIN specializations
ON vets.id = specializations.vet_id
WHERE specializations.vet_id IS NULL
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS "species", COUNT(animals.species_id)
FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals
ON animals.id = visits.animal_id
JOIN species
ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY count DESC LIMIT 1;

-- Find a way to decrease the execution time of the first query. Look for hints in the previous lessons.
SELECT COUNT (*) FROM visits WHERE animal_id = 4;
CREATE INDEX visits_animal_id
ON visits(animal_id);
EXPLAIN ANALYZE SELECT COUNT (*) FROM visits WHERE animal_id = 4;


-- decrease the execution time
SELECT * FROM visits where vet_id = 2;
CREATE INDEX visits_vet_id ON visits(vet_id);
EXPLAIN ANALYZE SELECT * FROM visits WHERE animal_id = 2;

-- decrease the execution time
SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX owners_email ON owners(email);
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';