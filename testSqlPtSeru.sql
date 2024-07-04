CREATE TABLE teachers (
    id serial,
    name varchar(100),
    subject varchar(50),
    PRIMARY key (id)
);

SELECT * from classes;

CREATE TABLE classes ( id serial, 
name VARCHAR(50), 
teacher_id INT, PRIMARY KEY(id), 
FOREIGN KEY (teacher_id) REFERENCES teachers(id));


CREATE TABLE students ( id serial, name VARCHAR(100), age INT, class_id INT, PRIMARY KEY(id), FOREIGN KEY (class_id) REFERENCES classes(id) );


INSERT INTO students (name, age, class_id) VALUES ('Budi', 16, 1); 
INSERT INTO students (name, age, class_id) VALUES ('Ani', 17, 2); 
INSERT INTO students (name, age, class_id) VALUES ('Candra', 18, 3);


INSERT INTO classes (name, teacher_id) VALUES ('Kelas 10A', 1); 
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 11B', 2); 
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 12C', 3);

SELECT * from teachers;

SELECT * from students;

INSERT INTO teachers (name, subject) VALUES ('Pak Anton', 'Matematika');

INSERT INTO teachers (name, subject) VALUES ('Bu Dina', 'Bahasa Indonesia'); 

INSERT INTO teachers (name, subject) VALUES ('Pak Eko', 'Biologi');

UPDATE classes set id = 3
WHERE id = 5;

SELECT * from classes;

DELETE from teachers where name = 'Pak Anton';
SELECT * from students;

SELECT 
*
FROM 
    students
JOIN 
    classes ON students.class_id = classes.id
JOIN
    teachers ON classes.teacher_id = teachers.id;


SELECT * from teachers;
SELECT * from classes;

SELECT 
    teachers.name AS teacher_name,
    classes.name AS kelas_nama
FROM 
    teachers
JOIN 
    classes ON teachers.id = classes.teacher_id;


    SELECT 
    teachers.name AS teacher_name, 
    STRING_AGG(classes.name, ', ') AS class_list 
FROM 
    classes 
JOIN 
    teachers ON classes.teacher_id = teachers.id 
GROUP BY 
    teachers.name;



    CREATE VIEW student_class_teacher AS 
SELECT 
    students.name AS student_name, 
    classes.name AS class_name, 
    teachers.name AS teacher_name 
FROM 
    students 
JOIN 
    classes ON students.class_id = classes.id 
JOIN 
    teachers ON classes.teacher_id = teachers.id;

    SELECT * FROM student_class_teachers;


-- 3 

CREATE VIEW student_class_teachers AS 
SELECT 
    students.name AS nama_murid, 
    classes.name AS nama_kelas, 
    teachers.name AS nama_guru 
FROM 
    students 
JOIN 
    classes ON students.class_id = classes.id 
JOIN 
    teachers ON classes.teacher_id = teachers.id;






SELECT * from students
join classes on students.class_id = classes.id
JOIN teachers on classes.teacher_id = teachers.id;


-- 4

CREATE OR REPLACE FUNCTION get_murid_kelas_guru() RETURNS TABLE (
    murid_name VARCHAR,
    kelas_name VARCHAR,
    guru_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        students.name, 
        classes.name, 
        teachers.name 
    FROM 
        students 
    JOIN 
        classes ON students.class_id = classes.id 
    JOIN 
        teachers ON classes.teacher_id = teachers.id;
END;
$$ LANGUAGE plpgsql;


SELECT * from get_murid_kelas_guru()

-- 5

ALTER TABLE students ADD CONSTRAINT unique_student UNIQUE (name, age, class_id);
ALTER TABLE classes ADD CONSTRAINT unique_class UNIQUE (name, teacher_id);
ALTER TABLE teachers ADD CONSTRAINT unique_teacher UNIQUE (name, subject);

INSERT into classes (name,teacher_id)
VALUES ('Kelas 10D', 1);



SELECT * from students;
SELECT * from teachers;
SELECT * FROM classes;



