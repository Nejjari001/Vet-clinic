CREATE TABLE patients(
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(250) NOT NULL,
	date_of_birth DATE
);

CREATE TABLE medical_histories(
	id SERIAL NOT NULL PRIMARY KEY,
	admitted_at TIMESTAMP,
	patient_id INT 
	REFERENCES patients(id) ON DELETE CASCADE,
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

CREATE TABLE invoices (
  id BIGSERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_histories
  FOREIGN KEY (medical_history_id)
  REFERENCES medical_histories(id)
);

-- Create invoices_items table
CREATE TABLE invoices_items (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoices
  FOREIGN KEY (invoice_id)
  REFERENCES invoices(id),
  CONSTRAINT fk_treatments
  FOREIGN KEY (treatment_id)
  REFERENCES treatments(id)
); 