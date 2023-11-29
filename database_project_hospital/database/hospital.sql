create database hospital;

use hospital;

CREATE TABLE medical_specialty (
    department_id BIGINT PRIMARY KEY,
    department_name VARCHAR(255),
    phone_number VARCHAR(11)
);

CREATE TABLE medical_staff (
    staff_id BIGINT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone_number VARCHAR(11),
    department_id BIGINT,
    username VARCHAR(255),
    password VARCHAR(255),
    role ENUM('doctor', 'nurse', 'admin'),
    FOREIGN KEY (department_id) REFERENCES medical_specialty(department_id)
);

CREATE TABLE patient (
    patient_id BIGINT PRIMARY KEY,
    name VARCHAR(255),
    social_security_number VARCHAR(20),
    gender VARCHAR(10),
    address VARCHAR(255),
    blood_type VARCHAR(5),
    height FLOAT,
    weight FLOAT,
    phone_number VARCHAR(11),
    staff_id BIGINT,
    username VARCHAR(255),
    password VARCHAR(255),
    FOREIGN KEY (staff_id) REFERENCES medical_staff(staff_id)
);

CREATE TABLE inpatient (
    inpatient_id BIGINT PRIMARY KEY,
    room_information VARCHAR(255),
    admission_date DATETIME,
    discharge_date_time DATETIME,
    patient_id BIGINT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE reservation (
    reservation_number BIGINT PRIMARY KEY,
    reservation_date_time DATETIME,
    department_id BIGINT,
    patient_id BIGINT,
    FOREIGN KEY (department_id) REFERENCES medical_specialty(department_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE examination (
    examination_id BIGINT PRIMARY KEY,
    examination_date_time DATETIME,
    examination_details TEXT,
    doctor_id BIGINT,
    patient_id BIGINT,
    FOREIGN KEY (doctor_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE treatment (
    treatment_id BIGINT PRIMARY KEY,
    treatment_date_time DATETIME,
    treatment_details TEXT,
    nurse_id BIGINT,
    patient_id BIGINT,
    FOREIGN KEY (nurse_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);
