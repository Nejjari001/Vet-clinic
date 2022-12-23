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