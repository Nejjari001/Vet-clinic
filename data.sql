/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Agumon', date '2020-02-03', 0, true, 10.23);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Gabumon', date '2018-11-15', 2, true, 8);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Pikachu', date '2021-01-07', 1, false, 15.04);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Devimon', date '2017-05-12', 5, true, 11);

/* Updated Table */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon','2021-11-15', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle','1993-04-02', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon','2005-06-12', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon','2005-06-07', 7, true, 20);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom','1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto','2022-05-14', 4, true, 22);

-- owners
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- species
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Digimon')
WHERE name LIKE '%mon%';

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

-- Insert the following data for vets:
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, 'April 23, 2000');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, 'January 17, 2019');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, 'May 4, 1981');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, 'June 8, 2008');

-- Insert the following data for specialties:
INSERT INTO specializations (vet_id, species_id)
VALUES (
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  (SELECT id FROM species WHERE name ='Pokemon')
);
INSERT INTO specializations (vet_id, species_id)
VALUES(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM species WHERE name = 'Digimon')
);
INSERT INTO specializations (vet_id, species_id)
VALUES(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM species WHERE name = 'Pokemon')
);
INSERT INTO specializations (vet_id, species_id)
VALUES(
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM species WHERE name = 'Digimon')
);

-- Insert the following data for visits:
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  (SELECT id FROM animals WHERE name = 'Agumon'),
  'May 24, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM animals WHERE name = 'Agumon'),
  'Jul 22, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM animals WHERE name = 'Gabumon'),
  'Feb 02, 2021'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Pikachu'),
  'Jan 05, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Pikachu'),
  'Mar 08, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Pikachu'),
  'May 14, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM animals WHERE name = 'Devimon'),
  'May 04, 2021'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM animals WHERE name = 'Charmander'),
  'Feb 24, 2021'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Plantmon'),
  'Dec 21, 2019'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  (SELECT id FROM animals WHERE name = 'Plantmon'),
  'Aug 10, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Plantmon'),
  'Apr 07, 2021'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM animals WHERE name = 'Squirtle'),
  'Sep 29, 2019'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM animals WHERE name = 'Angemon'),
  'Oct 03, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM animals WHERE name = 'Angemon'),
  'Nov 04, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Boarmon'),
  'Jan 24, 2019'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Boarmon'),
  'May 15, 2019'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Boarmon'),
  'Feb 27, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Maisy Smith'),
  (SELECT id FROM animals WHERE name = 'Boarmon'),
  'Aug 03, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM animals WHERE name = 'Blossom'),
  'May 24, 2020'
);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES(
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  (SELECT id FROM animals WHERE name = 'Blossom'),
  'Jan 11, 2021'
);

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';