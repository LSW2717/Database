create table building
(
    id   bigint       not null
        primary key,
    name varchar(255) null
);

CREATE TABLE department (
    id BIGINT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NULL,
    email VARCHAR(255) NULL,
    phone_number VARCHAR(255) NULL,
    building_id BIGINT NULL,
    CONSTRAINT FK_department_building FOREIGN KEY (building_id) REFERENCES inhadb.building (id)
);
create table club
(
    id   bigint       not null
        primary key,
    name varchar(255) null
);

CREATE TABLE student (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255),
    major VARCHAR(255),
    department_id BIGINT,
    club_id BIGINT,
    status VARCHAR(255),
    CONSTRAINT FK_student_department FOREIGN KEY (department_id) REFERENCES inhadb.department(id),
    CONSTRAINT FK_student_club FOREIGN KEY (club_id) REFERENCES inhadb.club(id)
);
create table lecture
(
    id                     bigint       not null
        primary key,
    professor              varchar(255) null,
    name                   varchar(255) null,
    number_of_participants bigint       null
);

CREATE TABLE room (
    id BIGINT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    capacity INT,
    building_id BIGINT,
    lecture_id BIGINT,
    CONSTRAINT FK_room_building FOREIGN KEY (building_id) REFERENCES inhadb.building(id),
    CONSTRAINT FK_room_lecture FOREIGN KEY (lecture_id) REFERENCES inhadb.lecture(id)
);

create table employee
(
    id          bigint       not null
        primary key,
    name        varchar(255) null,
    position    varchar(255) null,
    building_id bigint       null,
    constraint FK_employee_building foreign key (building_id) references inhadb.building (id)
);

INSERT INTO building VALUES(1, 'HighTech');
INSERT INTO building VALUES(2, 'Building2');
INSERT INTO building VALUES(3, 'Building5 ');
INSERT INTO building VALUES(4, 'Building9');
INSERT INTO building VALUES(5, '60thAnniversaryHall');

INSERT INTO department VALUE(101, 'ICE', 'ice@inha.edu', '03211111111', 1);
INSERT INTO department VALUE(102, 'CE', 'ce@inha.edu', '03222222222', 1);
INSERT INTO department VALUE(103, 'EE', 'ee@inha.edu', '03233333333', 1);
INSERT INTO department VALUE(201, 'ME', 'me@inha.edu', '03244444444', 2);
INSERT INTO department VALUE(202, 'AE', 'ae@inha.edu', '03255555555', 2);
INSERT INTO department VALUE(301, 'Math', 'math@inha.edu', '03266666666', 3);
INSERT INTO department VALUE(302, 'Pysical', 'pysical@inha.edu', '03277777777', 3);
INSERT INTO department VALUE(401, 'Business', 'business@inha.edu', '03288888888', 4);
INSERT INTO department VALUE(402, 'Economics', 'economics@inha.edu', '03299999999', 4);
INSERT INTO department VALUE(501, 'Premedica', 'premedica@inha.edu', '03200000000', 5);

INSERT INTO club VALUE(2001, 'coding');
INSERT INTO club VALUE(2002, 'soccer');
INSERT INTO club VALUE(2003, 'baseball');
INSERT INTO club VALUE(2004, 'basketball');
INSERT INTO club VALUE(2005, 'baking');

INSERT INTO student VALUE(12171260, 'Siwon', 'siwon2717@gmail.com', '01094164194', 'ICE', 101, 2001, 'SUPER');
INSERT INTO student VALUE(10, 'Emma', 'emma@inha.edu', '01000000001', 'ICE', 101, 2001, 'STUDENT');
INSERT INTO student VALUE(11, 'Liam', 'liam@inha.edu', '01000000002', 'ICE', 101, 2001, 'STUDENT');
INSERT INTO student VALUE(12, 'Olivia', 'olivia@inha.edu', '01000000003', 'CE', 102, 2001, 'STUDENT');
INSERT INTO student VALUE(13, 'Noah', 'noah@inha.edu', '01000000004', 'CE', 102, 2001, 'STUDENT');
INSERT INTO student VALUE(14, 'Ava', 'ava@inha.edu', '01000000005', 'EE', 103, 2002, 'STUDENT');
INSERT INTO student VALUE(15, 'Ethan', 'ethan@inha.edu', '01000000006', 'EE', 103, 2002, 'STUDENT');
INSERT INTO student VALUE(16, 'Sophia', 'sophia@inha.edu', '01000000007', 'ME', 201, 2002, 'STUDENT');
INSERT INTO student VALUE(17, 'Mason', 'mason@inha.edu', '01000000008', 'ME', 201, 2003, 'STUDENT');
INSERT INTO student VALUE(18, 'Lsabella', 'lsabella@inha.edu', '01000000009', 'AE', 202, 2003, 'STUDENT');
INSERT INTO student VALUE(19, 'William', 'william@inha.edu', '01000000010', 'AE', 202, 2003, 'STUDENT');
INSERT INTO student VALUE(20, 'Mia', 'mia@inha.edu', '01000000011', 'Math', 301, 2003, 'STUDENT');
INSERT INTO student VALUE(21, 'James', 'james@inha.edu', '01000000012', 'Math', 301, 2004, 'STUDENT');
INSERT INTO student VALUE(22, 'Charlotte', 'charlotte@inha.edu', '01000000013', 'Pysical', 302, 2004, 'STUDENT');
INSERT INTO student VALUE(23, 'Benjamin', 'benjamin@inha.edu', '01000000014', 'Pysical', 302, 2004, 'STUDENT');
INSERT INTO student VALUE(24, 'Amelia', 'amelia@inha.edu', '01000000015', 'Business', 401, 2004, 'STUDENT');
INSERT INTO student VALUE(25, 'Samuel', 'samuel@inha.edu', '01000000016', 'Business', 401, 2005, 'STUDENT');
INSERT INTO student VALUE(26, 'Harper', 'harper@inha.edu', '01000000017', 'Economics', 402, 2005, 'STUDENT');
INSERT INTO student VALUE(27, 'Elijah', 'elijah@inha.edu', '01000000018', 'Economics', 402, 2005, 'STUDENT');
INSERT INTO student VALUE(28, 'Abigail', 'abigail@inha.edu', '01000000019', 'Premedica', 501, 2005, 'STUDENT');
INSERT INTO student VALUE(29, 'Henry', 'henry@inha.edu', '01000000020', 'Premedica', 501, 2005, 'STUDENT');

INSERT INTO lecture VALUE(3001, 'John Anderson', 'Algorithm Analysis', 50);
INSERT INTO lecture VALUE(3002, 'Emily Thompson', 'Database Systems', 40);
INSERT INTO lecture VALUE(3003, 'Michael Richards', 'Machine Learning', 55);
INSERT INTO lecture VALUE(3004, 'Sarah Mitchell', 'Thermodynamics', 35);
INSERT INTO lecture VALUE(3005, 'Robert White', 'Fluid Mechanics', 45);
INSERT INTO lecture VALUE(3006, 'Olivia Harris', 'Dynamics and Control', 60);
INSERT INTO lecture VALUE(3007, 'David Johnson', 'Educational Psychology', 70);
INSERT INTO lecture VALUE(3008, 'Sophia Brown', 'Curriculum Development', 30);
INSERT INTO lecture VALUE(3009, 'William Martin', 'Classroom Management', 40);
INSERT INTO lecture VALUE(3010, 'Isabella Lewis', 'Financial Accounting', 50);
INSERT INTO lecture VALUE(3011, 'Joseph Clark', 'Marketing Strategies', 45);
INSERT INTO lecture VALUE(3012, 'Mia Taylor', 'Organizational Behavior', 35);
INSERT INTO lecture VALUE(3013, 'James Wilson', 'Human Anatomy', 60);
INSERT INTO lecture VALUE(3014, 'Charlotte Lee', 'Clinical Medicine', 25);
INSERT INTO lecture VALUE(3015, 'Henry Davis', 'Pharmacology', 55);

INSERT INTO room VALUE(1001, '101room', 40, 1, 3001);
INSERT INTO room VALUE(1002, '202room', 40, 1, 3002);
INSERT INTO room VALUE(1003, '303room', 40, 1, 3003);
INSERT INTO room VALUE(1004, '101room', 40, 2, 3004);
INSERT INTO room VALUE(1005, '202room', 40, 2, 3005);
INSERT INTO room VALUE(1006, '303room', 40, 2, 3006);
INSERT INTO room VALUE(1007, '101room', 40, 3, 3007);
INSERT INTO room VALUE(1008, '202room', 40, 3, 3008);
INSERT INTO room VALUE(1009, '303room', 40, 3, 3009);
INSERT INTO room VALUE(1010, '101room', 40, 4, 3010);
INSERT INTO room VALUE(1011, '202room', 40, 4, 3011);
INSERT INTO room VALUE(1012, '303room', 40, 4, 3012);
INSERT INTO room VALUE(1013, '101room', 40, 5, 3013);
INSERT INTO room VALUE(1014, '202room', 40, 5, 3014);
INSERT INTO room VALUE(1015, '303room', 40, 5, 3015);

INSERT INTO employee VALUE(4001,'Kim', 'cleaner', 1);
INSERT INTO employee VALUE(4002,'Lee', 'schoolPersonnel', 1);
INSERT INTO employee VALUE(4003,'Park', 'cleaner', 2);
INSERT INTO employee VALUE(4004,'Chae', 'schoolPersonnel', 2);
INSERT INTO employee VALUE(4005,'Kim', 'cleaner', 3);
INSERT INTO employee VALUE(4006,'Lee', 'schoolPersonnel', 3);
INSERT INTO employee VALUE(4007,'Park', 'cleaner', 4);
INSERT INTO employee VALUE(4008,'Song', 'schoolPersonnel', 4);
INSERT INTO employee VALUE(4009,'Lee', 'cleaner', 5);
INSERT INTO employee VALUE(4010,'Choi', 'schoolPersonnel', 5);