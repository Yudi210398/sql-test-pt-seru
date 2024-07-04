-- Bikin table semua

CREATE TABLE teachers (
    id serial,
    name varchar(100),
    subject varchar(50),
    PRIMARY key (id)
);

CREATE TABLE classes ( 
id serial, 
name VARCHAR(50), 
teacher_id INT, 
PRIMARY KEY(id), 
FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE students ( 
id serial, 
name VARCHAR(100), age INT,
class_id INT, PRIMARY KEY(id), 
FOREIGN KEY (class_id) REFERENCES classes(id) 
);

-- input data semua

INSERT INTO teachers (name, subject) VALUES ('Pak Anton', 'Matematika');
INSERT INTO teachers (name, subject) VALUES ('Bu Dina', 'Bahasa Indonesia'); 
INSERT INTO teachers (name, subject) VALUES ('Pak Eko', 'Biologi');


INSERT INTO classes (name, teacher_id) VALUES ('Kelas 10A', 1); 
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 11B', 2); 
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 12C', 3);


INSERT INTO students (name, age, class_id) VALUES ('Budi', 16, 1); 
INSERT INTO students (name, age, class_id) VALUES ('Ani', 17, 2); 
INSERT INTO students (name, age, class_id) VALUES ('Candra', 18, 3);


-- soal nomor 1 


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


-- soal nomor 2 



SELECT 
    teachers.name AS teacher_name, 
    STRING_AGG(classes.name, ', ') AS class_list 
FROM 
    classes 
JOIN 
    teachers ON classes.teacher_id = teachers.id 
GROUP BY 
    teachers.name;


-- soal nomor 3

CREATE VIEW murid_kelas_guru AS 
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

SELECT * from murid_kelas_guru;


-- soal nomor 4 

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


SELECT * from get_murid_kelas_guru();


-- soal nomor 5

ALTER TABLE students ADD CONSTRAINT unique_student UNIQUE (name, age, class_id);
ALTER TABLE classes ADD CONSTRAINT unique_class UNIQUE (name, teacher_id);
ALTER TABLE teachers ADD CONSTRAINT unique_teacher UNIQUE (name, subject);



