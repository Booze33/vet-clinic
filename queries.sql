/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '1/01/2016' AND '1/01/2019';
SELECT name from animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Pikachu' OR name = 'Agumon';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * from animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * from animals;
COMMIT;
SELECT * from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save_point;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO save_point;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '1999-12-31' GROUP BY species;

SELECT name FROM animals JOIN owners O ON owner_id = O.id WHERE full_name = 'Melody Pond';
SELECT A.name FROM animals A JOIN species S ON species_id = S.id WHERE S.name = 'Pokemon';
SELECT full_name AS owner, name AS animal FROM animals RIGHT JOIN owners O ON owner_id = O.id;
SELECT S.name, COUNT(*) FROM species S JOIN animals ON  S.id = species_id GROUP BY S.name;
SELECT A.name FROM animals A JOIN owners O ON owner_id = O.id JOIN species S ON species_id = S.id WHERE full_name = 'Jennifer Orwell' AND S.name = 'Digimon';
SELECT name FROM animals JOIN owners O ON owner_id = O.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;
SELECT full_name, COUNT(*) AS animal_count FROM owners O JOIN animals ON O.id = owner_id GROUP BY full_name ORDER BY animal_count DESC LIMIT 1;

SELECT A.name FROM animals A JOIN visits ON A.id = animal_id JOIN vets V ON vet_id = V.id WHERE V.name = 'William Tatcher' ORDER BY visit_date DESC LIMIT 1;
SELECT COUNT(DISTINCT A.name) FROM animals A JOIN visits ON A.id = animal_id JOIN vets V ON vet_id = V.id WHERE V.name = 'Stephanie Mendez';
SELECT V.name, S.name AS specialty FROM vets V LEFT JOIN specializations ON vet_id = V.id LEFT JOIN species S ON species_id = S.id;
SELECT A.name FROM animals A JOIN visits ON A.id = animal_id JOIN vets V ON vet_id = V.id WHERE V.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';
SELECT A.name, COUNT(*) FROM animals A JOIN visits ON A.id = animal_id GROUP BY A.name ORDER BY count DESC LIMIT 1;
SELECT A.name, visit_date FROM animals A JOIN visits ON A.id = animal_id JOIN vets V ON vet_id = V.id WHERE V.name = 'Maisy Smith' ORDER BY visit_date ASC LIMIT 1;
SELECT A.name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, S.name AS species, V.name AS vet_name, V.age AS vet_age, V.date_of_graduation AS vet_date_of_graduation, visit_date FROM animals A JOIN species S ON A.species_id = S.id JOIN visits ON A.id = animal_id JOIN vets V ON vet_id = V.id ORDER BY visit_date DESC LIMIT 1;
SELECT COUNT(*) FROM visits JOIN animals A ON animal_id = A.id JOIN vets V ON vet_id = V.id LEFT JOIN specializations SP ON A.species_id = SP.species_id AND V.id = SP.vet_id WHERE SP.species_id IS NULL OR SP.vet_id IS NULL;
SELECT S.name as species, COUNT(*) FROM visits JOIN animals A ON animal_id = A.id JOIN species S ON A.species_id = S.id JOIN vets V ON vet_id = V.id WHERE V.name = 'Maisy Smith' GROUP BY S.name;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
