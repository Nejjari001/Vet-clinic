/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
CREATE TABLE animals (
    id BIGSERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id)
);

--Update animals table
ALTER TABLE animals
ADD COLUMN species VARCHAR(30);