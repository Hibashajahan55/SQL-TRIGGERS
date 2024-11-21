# SQL TRIGGERS
## Introduction

Triggers and events are essential SQL mechanisms for automating processes within a database:



Triggers are automated responses to specific changes (INSERT, UPDATE, DELETE) in a table.

Events are scheduled tasks set to run at specific times or intervals.

These features improve data consistency, automate tasks, and reduce manual efforts in database management.
## SQL Triggers

What are Triggers?

Triggers are actions automatically executed when specific changes occur in a table. They’re used for tasks such as:



* Validating data before/after an update

* Logging changes

* Maintaining referential integrity

## Syntax:



CREATE TRIGGER trigger_name

{BEFORE | AFTER} {INSERT | UPDATE | DELETE}

ON table_name

FOR EACH ROW

BEGIN

    -- Trigger body (SQL statements)

END;

## Conclusion
Triggers and events are powerful automation tools in SQL, improving data consistency and efficiency in database management
