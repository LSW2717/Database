CREATE DATABASE hospital;

USE hospital;

CREATE TABLE medical_specialty (
    department_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255),
    phone_number VARCHAR(11)
);

CREATE TABLE medical_staff (
    staff_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone_number VARCHAR(11),
    department_id BIGINT,
    username VARCHAR(255),
    password VARCHAR(255),
    role ENUM('DOCTOR', 'NURSE', 'ADMIN'),
    FOREIGN KEY (department_id) REFERENCES medical_specialty(department_id)
);

CREATE TABLE patient (
    patient_id BIGINT AUTO_INCREMENT PRIMARY KEY,
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
    inpatient_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    room_information VARCHAR(255),
    admission_date DATETIME,
    discharge_date_time DATETIME,
    patient_id BIGINT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE reservation (
    reservation_number BIGINT AUTO_INCREMENT PRIMARY KEY,
    reservation_date_time DATETIME,
    department_id BIGINT,
    patient_id BIGINT,
    FOREIGN KEY (department_id) REFERENCES medical_specialty(department_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE examination (
    examination_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    examination_date_time DATETIME,
    examination_details TEXT,
    doctor_id BIGINT,
    patient_id BIGINT,
    FOREIGN KEY (doctor_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE treatment (
    treatment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    treatment_date_time DATETIME,
    treatment_details TEXT,
    nurse_id BIGINT,
    patient_id BIGINT,
    FOREIGN KEY (nurse_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

INSERT INTO medical_specialty (department_id, department_name, phone_number) VALUES
(101, '심장과', '1234567890'),
(102, '신경과', '1234567891'),
(103, '소아과', '1234567892');

INSERT INTO medical_staff (staff_id, name, address, phone_number, department_id, username, password, role) VALUES
(201, '의사 김철수', '서울시 강남구', '2345678901', 101, 'drkim', 'pass123', 'DOCTOR'),
(202, '간호사 이영희', '서울시 서초구', '2345678902', 102, 'nurselee', 'pass123', 'NURSE'),
(203, '관리자 박지민', '서울시 용산구', '2345678903', 103, 'adminpark', 'pass123', 'ADMIN');

INSERT INTO patient (patient_id, name, social_security_number, gender, address, blood_type, height, weight, phone_number, staff_id, username, password) VALUES
(301, '환자 A', '123-45-6789', '여성', '서울시 마포구', 'A+', 170.2, 70, '3456789012', 201, 'patienta', 'pass123'),
(302, '환자 B', '987-65-4321', '남성', '서울시 강서구', 'B-', 180.4, 80, '3456789013', 202, 'patientb', 'pass123'),
(303, '환자 C', '321-54-6789', '여성', '서울시 동작구', 'O+', 160.5, 60, '3456789014', 203, 'patientc', 'pass123');

INSERT INTO inpatient (inpatient_id, room_information, admission_date, discharge_date_time, patient_id) VALUES
(401, '101호', '2023-01-01 10:00:00', '2023-01-10 12:00:00', 301),
(402, '102호', '2023-01-05 11:00:00', '2023-01-15 14:00:00', 302),
(403, '103호', '2023-01-10 09:30:00', '2023-01-20 16:00:00', 303);

INSERT INTO reservation (reservation_number, reservation_date_time, department_id, patient_id) VALUES
(501, '2023-02-01 09:00:00', 101, 301),
(502, '2023-02-02 10:00:00', 102, 302),
(503, '2023-02-03 11:00:00', 103, 303);

INSERT INTO examination (examination_id, examination_date_time, examination_details, doctor_id, patient_id) VALUES
(601, '2023-03-01 09:30:00', '심장 검사', 201, 301),
(602, '2023-03-02 10:30:00', '뇌 MRI 검사', 201, 302),
(603, '2023-03-03 11:30:00', '일반 건강 검진', 201, 303);

INSERT INTO treatment (treatment_id, treatment_date_time, treatment_details, nurse_id, patient_id) VALUES
(701, '2023-04-01 08:00:00', '혈압 관리', 202, 301),
(702, '2023-04-02 08:30:00', '수술 후 관리', 202, 302),
(703, '2023-04-03 09:00:00', '약물 투여', 202, 303);
