/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
USE vet_clinic;
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
  id INT  GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(25) NOT NULL,
  date_of_birth date,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(40);

DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;

CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(25) NOT NULL,
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(25) NOT NULL,
  PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD CONSTRAINT FK_AnimalSpecies FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD owner_id INT;


DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(25) NOT NULL,
  age INT,
  date_of_graduation date,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  species_id INT,
	vet_id INT,
	PRIMARY KEY(species_id, vet_id),
	FOREIGN KEY (species_id) REFERENCES species(id),
	FOREIGN KEY (vet_id) REFERENCES vets(id)
);

CREATE TABLE visits (
  vet_id INT,
	animal_id INT,
	visit_date DATE,
	PRIMARY KEY(vet_id, animal_id, visit_date),
	FOREIGN KEY (vet_id) REFERENCES vets(id),
	FOREIGN KEY (animal_id) REFERENCES animals(id)
)