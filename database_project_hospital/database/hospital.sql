CREATE DATABASE hospital;

USE hospital;

CREATE TABLE medical_specialty (
    department_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255),
    phone_number VARCHAR(13)
);

CREATE TABLE medical_staff (
    staff_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone_number VARCHAR(13),
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
    phone_number VARCHAR(13),
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
-- READ작업을 할거에만 INDEX 만듬
CREATE INDEX idx_department_name ON medical_specialty(department_name);
CREATE INDEX idx_room_information ON inpatient(room_information);

-- 환자,담당의로진 view
CREATE VIEW view_patient_staff AS
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.address AS patient_address,
    p.phone_number AS patient_phone,
    m.name AS staff_name,
    m.role AS staff_role
FROM 
    patient p
JOIN 
    medical_staff m ON p.staff_id = m.staff_id;

-- 환자, 예약 view
CREATE VIEW view_patient_reservation AS
SELECT 
    p.patient_id,
    p.name AS patient_name,
    r.reservation_number,
    r.reservation_date_time,
    ms.department_name
FROM 
    patient p
JOIN 
    reservation r ON p.patient_id = r.patient_id
JOIN 
    medical_specialty ms ON r.department_id = ms.department_id;

-- 환자, 검사 view
CREATE VIEW view_patient_examination AS
SELECT 
    p.patient_id,
    p.name AS patient_name,
    e.examination_id,
    e.examination_date_time,
    e.examination_details
FROM 
    patient p
JOIN 
    examination e ON p.patient_id = e.patient_id;

-- 환자, 치료 view
CREATE VIEW view_patient_treatment AS
SELECT 
    p.patient_id,
    p.name AS patient_name,
    t.treatment_id,
    t.treatment_date_time,
    t.treatment_details
FROM 
    patient p
JOIN 
    treatment t ON p.patient_id = t.patient_id;


-- 간단한 TRANSACTION 적용
START TRANSACTION;

INSERT INTO medical_specialty (department_id, department_name, phone_number) VALUES
(101, '심장과', '02-1234-1001'),
(102, '신경과', '02-1234-1002'),
(103, '이빈후과', '02-1234-1003'),
(104, '내과', '02-1234-1004'),
(105, '외과', '02-1234-1005'),
(106, '소아과', '02-1234-1006');

INSERT INTO medical_staff (staff_id, name, address, phone_number, department_id, username, password, role) VALUES
(201, '이시원', '서울 강동구', '010-9416-4194', 101, 'siwon0807', 'tldnjs0807', 'ADMIN'),
(202, '김철수', '서울 강남구', '010-1234-1001', 101, 'doctorkim', 'pass123', 'DOCTOR'),
(203, '이영희', '서울 서초구', '010-1234-1002', 101, 'nurselee', 'pass123', 'NURSE'),
(204, '박준혁', '서울 동작구', '010-1234-1003', 102, 'doctorpark', 'newpass1', 'DOCTOR'),
(205, '최유나', '서울 강서구', '010-1234-1004', 102, 'nursechoi', 'newpass2', 'NURSE'),
(206, '정민수', '인천 남구', '010-1234-1005', 103, 'doctorjung', 'newpass3', 'DOCTOR'),
(207, '김지영', '인천 동구', '010-1234-1006', 103, 'nursekim', 'newpass4', 'NURSE'),
(208, '이태준', '인천 서구', '010-1234-1007', 104, 'doctortae', 'newpass5', 'DOCTOR'),
(209, '박서현', '서울 영등포', '010-1234-1008', 104, 'nursepark', 'newpass6', 'NURSE'),
(210, '김동욱', '서울 마천', '010-1234-1009', 105, 'doctorkimdw', 'newpass7', 'DOCTOR'),
(211, '이소라', '서울 상일', '010-1234-1010', 105, 'nurselee2', 'newpass8', 'NURSE'),
(212, '정현우', '서울 잠실', '010-1234-1011', 106, 'doctorjunghw', 'newpass9', 'DOCTOR'),
(213, '최윤지', '인천 용현동', '010-1234-1012', 106, 'nursechoiyj', 'newpass10', 'NURSE');


INSERT INTO patient (patient_id, name, social_security_number, gender, address, blood_type, height, weight, phone_number, staff_id, username, password) VALUES
(301, '박민수', '123-45-6789', '남성', '서울시 마포구', 'A+', 170.2, 70, '010-3456-1001', 202, 'patienta', 'pass123'),
(302, '이지훈', '987-65-4321', '남성', '서울시 강서구', 'B-', 180.4, 80, '010-3456-1002', 202, 'patientb', 'pass123'),
(303, '최윤서', '890-76-5432', '여성', '서울시 동작구', 'AB+', 158.7, 50, '010-3456-1005', 203, 'patiente', 'pass123'),
(304, '정다은', '312-65-8790', '여성', '서울시 강남구', 'B+', 162.9, 54, '010-3456-1006', 203, 'patientf', 'pass123'),
(305, '송태민', '098-87-6543', '남성', '서울시 서초구', 'A+', 178.2, 77, '010-3456-1008', 204, 'patienth', 'pass123'),
(306, '유서진', '213-76-0981', '여성', '서울시 마포구', 'AB-', 167.5, 56, '010-3456-1009', 204, 'patienti', 'pass123'),
(307, '이하은', '567-98-7654', '여성', '서울시 영등포구', 'A-', 159.6, 52, '010-3456-1011', 205, 'patientk', 'pass123'),
(308, '박소연', '435-89-0123', '여성', '서울시 관악구', 'O+', 163.8, 57, '010-3456-1012', 205, 'patientl', 'pass123'),
(309, '이수민', '789-01-2345', '남성', '인천 동구', 'B-', 180.6, 78, '010-3456-1014', 206, 'patientn', 'pass123'),
(310, '최유나', '876-12-3456', '여성', '인천 계양구', 'A+', 168.4, 58, '010-3456-1015', 206, 'patiento', 'pass123'),
(311, '박지호', '654-34-5678', '남성', '인천 부평구', 'AB-', 172.7, 68, '010-3456-1017', 207, 'patientq', 'pass123'),
(312, '유다인', '543-45-6789', '여성', '인천 중구', 'B+', 161.3, 55, '010-3456-1018', 207, 'patientr', 'pass123'),
(313, '최현우', '321-67-8901', '남성', '인천 연수구', 'O+', 176.8, 74, '010-3456-1020', 208, 'patientt', 'pass123'),
(314, '한소희', '210-78-9012', '여성', '인천 남동구', 'AB+', 170.0, 60, '010-3456-1021', 208, 'patientu', 'pass123'),
(315, '강하늘', '109-89-0123', '남성', '서울 영등포구', 'B-', 179.3, 79, '010-3456-1022', 209, 'patientv', 'pass123'),
(316, '손예진', '098-90-1234', '여성', '서울 구로구', 'A-', 162.7, 54, '010-3456-1023', 209, 'patientw', 'pass123'),
(317, '김태희', '876-12-3456', '여성', '서울 마천구', 'AB-', 168.9, 59, '010-3456-1025', 210, 'patienty', 'pass123'),
(318, '장동건', '765-23-4567', '남성', '서울 상일동', 'B+', 182.1, 81, '010-3456-1026', 210, 'patientz', 'pass123'),
(319, '조인성', '543-45-6789', '남성', '서울 잠실', 'O-', 178.2, 75, '010-3456-1028', 211, 'patientbb', 'pass123'),
(320, '김고은', '432-56-7890', '여성', '인천 용현동', 'AB+', 164.0, 52, '010-3456-1029', 211, 'patientcc', 'pass123'),
(321, '강동원', '321-54-6789', '남성', '서울시 동작구', 'O+', 160.5, 60, '010-3456-1003', 212, 'patientc', 'pass123'),
(322, '이병헌', '321-67-8901', '남성', '인천 중동', 'B-', 181.5, 76, '010-3456-1030', 212, 'patientdd', 'pass123'),
(323, '전지현', '654-34-5678', '여성', '서울 송파구', 'A+', 166.4, 56, '010-3456-1027', 213, 'patientaa', 'pass123'),
(324, '이준기', '987-01-2345', '남성', '서울 강북구', 'O+', 175.6, 73, '010-3456-1024', 213, 'patientx', 'pass123');

INSERT INTO inpatient (inpatient_id, room_information, admission_date, discharge_date_time, patient_id) VALUES
(401, '101호', '2024-01-01 10:00:00', '2024-01-10 12:00:00', 301),
(402, '102호', '2024-01-05 11:00:00', '2024-01-15 14:00:00', 302),
(403, '204호', '2024-01-02 08:45:00', '2024-01-12 10:30:00', 304),
(404, '205호', '2024-01-06 10:00:00', '2024-01-16 11:00:00', 305),
(405, '306호', '2024-01-08 14:00:00', '2024-01-18 15:00:00', 311),
(406, '307호', '2024-01-03 09:00:00', '2024-01-13 10:00:00', 313),
(407, '408호', '2024-01-04 13:30:00', '2024-01-14 14:30:00', 317),
(408, '409호', '2024-01-07 12:00:00', '2024-01-17 13:00:00', 319),
(409, '510호', '2024-01-09 16:00:00', '2024-01-19 17:00:00', 322),
(410, '511호', '2024-01-11 15:30:00', '2024-01-21 16:30:00', 324);

INSERT INTO reservation (reservation_number, reservation_date_time, department_id, patient_id) VALUES
(501, '2024-02-04 09:30:00', 101, 301),
(502, '2024-02-05 10:30:00', 101, 304),
(503, '2024-02-06 11:15:00', 102, 307),
(504, '2024-02-07 08:45:00', 102, 308),
(505, '2024-02-08 14:00:00', 103, 309),
(506, '2024-02-09 15:30:00', 103, 310),
(507, '2024-02-10 16:00:00', 104, 311),
(508, '2024-02-11 08:30:00', 104, 312),
(509, '2024-02-12 09:00:00', 105, 313),
(510, '2024-02-13 10:45:00', 106, 314);

INSERT INTO examination (examination_id, examination_date_time, examination_details, doctor_id, patient_id) VALUES
(601, '2024-01-01 09:30:00', '심장 검사', 202, 301),
(602, '2024-01-02 10:30:00', '뇌 MRI 검사', 202, 302),
(603, '2024-01-03 11:30:00', '일반 건강 검진', 204, 303),
(604, '2024-01-04 09:00:00', '혈액 검사', 204, 304),
(605, '2024-01-05 10:00:00', '피부 알레르기 검사', 206, 305),
(606, '2024-01-06 11:00:00', 'X-레이 검사', 206, 306),
(607, '2024-01-07 08:30:00', '초음파 검사', 208, 307),
(608, '2024-01-08 13:30:00', '척추 MRI 검사', 208, 308),
(609, '2024-01-09 14:30:00', '갑상선 기능 검사', 210, 309),
(610, '2024-01-10 15:30:00', '당뇨병 검사', 210, 310),
(611, '2024-01-11 16:00:00', '호흡기 기능 검사', 212, 311),
(612, '2024-01-12 08:45:00', '위내시경 검사', 212, 312);

INSERT INTO treatment (treatment_id, treatment_date_time, treatment_details, nurse_id, patient_id) VALUES
(701, '2023-04-01 08:00:00', '혈압 관리', 203, 313),
(702, '2023-04-02 08:30:00', '수술 후 관리', 203, 314),
(703, '2023-04-03 09:00:00', '약물 투여', 205, 315),
(704, '2023-04-04 08:15:00', '상처 관리', 205, 316),
(705, '2023-04-05 08:45:00', '정기적인 활력징후 체크', 207, 317),
(706, '2023-04-06 09:30:00', '임상 영양 관리', 207, 318),
(707, '2023-04-07 10:00:00', '개인 위생 관리', 209, 319),
(708, '2023-04-08 10:30:00', '통증 관리', 209, 320),
(709, '2023-04-09 11:00:00', '호흡기 관리', 211, 321),
(710, '2023-04-10 11:30:00', '이동 및 활동 지원', 211, 322),
(711, '2023-04-11 12:00:00', '수면 관리', 213, 323),
(712, '2023-04-12 12:30:00', '감염 관리', 213, 324);

COMMIT;