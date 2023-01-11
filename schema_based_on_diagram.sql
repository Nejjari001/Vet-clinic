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


CREATE TABLE treatments (
	id SERIAL NOT NULL PRIMARY KEY,
	type VARCHAR(250) NOT NULL,
	name VARCHAR(250) NOT NULL
);


CREATE TABLE treatment_histories(
   treatment_id INT REFERENCES treatments(id) ON DELETE CASCADE,
   histories_id INT REFERENCES medical_histories(id) ON DELETE CASCADE
);
