CREATE TABLE patients(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(250) NOT NULL,
    date_of_birth DATE
);

CREATE TABLE medical_histories(
id SERIAL NOT NULL PRIMARY KEY,
admitted_at TIMESTAMP,
patient_id INT
REFERENCES patient(id) ON DELETE CASCADE,
status VARCHAR(250) NOT NULL
);