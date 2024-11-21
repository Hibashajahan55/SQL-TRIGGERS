/*
Triggers
1. Create a table named teachers with fields id, name, subject, experience and salary and insert 8 rows. 
2. Create a before insert trigger named before_insert_teacher that will raise an error “salary cannot be negative” if the salary inserted to the table is less than zero.
3. Create an after insert trigger named after_insert_teacher that inserts a row with teacher_id,action, timestamp to a table called teacher_log when a new entry gets inserted to the teacher table. tecaher_id -> column of teacher table, action -> the trigger action, timestamp -> time at which the new row has got inserted. 
4. Create a before delete trigger that will raise an error when you try to delete a row that has experience greater than 10 years. 
5. Create an after delete trigger that will insert a row to teacher_log table when that row is deleted from teacher table.
*/
USE ENTRI_D41;
-- 1. Create a table named teachers with fields id, name, subject, experience and salary and insert 8 rows. 
CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    subject VARCHAR(50),
    experience INT,
    salary DECIMAL(10, 2)
);

DESC teachers;

INSERT INTO teachers (name, subject, experience, salary) VALUES
('John Doe', 'Math', 8, 50000),
('Jane Smith', 'Science', 12, 60000),
('Emily Davis', 'English', 5, 45000),
('Michael Brown', 'History', 3, 40000),
('Sarah Wilson', 'Geography', 15, 70000),
('David Lee', 'Physics', 10, 55000),
('Laura Taylor', 'Chemistry', 2, 38000),
('James Anderson', 'Biology', 7, 48000);
SELECT * FROM teachers;

/* 2. Create a before insert trigger named before_insert_teacher that will raise an error “salary cannot be negative” 
if the salary inserted to the table is less than zero.*/

DELIMITER //

CREATE TRIGGER before_insert_teacher
BEFORE INSERT ON teachers
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END //

DELIMITER ;

INSERT INTO teachers (name, subject, experience, salary)
VALUES('Johny Alwy', 'Mathematics', 10, -50000.00);

/* 3. Create an after insert trigger named after_insert_teacher that inserts a row with teacher_id,action, 
timestamp to a table called teacher_log when a new entry gets inserted to the teacher table. 
tecaher_id -> column of teacher table, action -> the trigger action, timestamp -> time at which the new row has got inserted. */

CREATE TABLE teacher_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT,
    action VARCHAR(50),
    log_timestamp DATETIME
);

DESC teacher_log;

DELIMITER //

CREATE TRIGGER after_insert_teacher
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action, log_timestamp)
    VALUES (NEW.id, 'INSERT', NOW());
END //

DELIMITER ;

INSERT INTO teachers (name, subject, experience, salary)
VALUES
('Symon Karle', 'Mathematics', 9, 57000.00);
select * from teachers;

select * from teacher_log;

-- 4. Create a before delete trigger that will raise an error when you try to delete a row that has experience greater than 10 years. 
DELIMITER //

CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON teachers
FOR EACH ROW
BEGIN
    IF OLD.experience > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete a teacher with experience greater than 10 years';
    END IF;
END //

DELIMITER ;

DELETE FROM TEACHERS WHERE EXPERIENCE=10;
DELETE FROM TEACHERS WHERE EXPERIENCE=15;
-- 5. Create an after delete trigger that will insert a row to teacher_log table when that row is deleted from teacher table.
DELIMITER //

CREATE TRIGGER after_delete_teacher
AFTER DELETE ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action, log_timestamp)
    VALUES (OLD.id, 'DELETE', NOW());
END //

DELIMITER ;

DELETE FROM TEACHERS WHERE ID= 2;
SELECT * FROM TEACHERS ;
select * from teacher_log;


