/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOL NOT NULL,
    weight_kg DECIMAL NOT NULLو
    species  VARCHAR(50)
);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(60),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    PRIMARY KEY(id)
);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation date,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    CONSTRAINT vets_id FOREIGN KEY(vets_id) REFERENCES vets(id),
    CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    vets_id INT,
    animals_id INT,
    visit_date DATE,
    CONSTRAINT vets_id FOREIGN KEY(vets_id) REFERENCES vets(id),
    CONSTRAINT animals_id FOREIGN KEY(animals_id) REFERENCES animals(id)
);

-- Delete species column
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals 
    ADD species_id INT,
    ADD CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
    ADD owner_id INT,
    ADD CONSTRAINT owner_id FOREIGN KEY(owner_id) REFERENCES owners(id);
    