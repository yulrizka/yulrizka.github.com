---
layout: post
title: "Postgres Audit Log Trigger"
date: 2021-02-02T13:54:20+01:00
language: en
comments: true
tags: 
description: 
keywords: 
draft: false
---

This triggers will log before and after fields for a table in JSON format.

```sql
CREATE TABLE changelog
(
	id         serial NOT NULL,
	ts         timestamp DEFAULT NOW(),
	table_name text,
	operation  text,
	new_val    json,
	old_val    json
);

CREATE INDEX changelog_ts_table_name_index
	ON changelog (ts DESC, table_name ASC);

CREATE OR REPLACE FUNCTION logchange() RETURNS trigger AS
$$
BEGIN
	IF TG_OP = 'INSERT'
	THEN
		INSERT INTO changelog (table_name, operation, new_val)
		VALUES (TG_RELNAME, TG_OP, ROW_TO_JSON(NEW));
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE'
	THEN
		INSERT INTO changelog (table_name, operation, new_val, old_val)
		VALUES (TG_RELNAME, TG_OP, ROW_TO_JSON(NEW), ROW_TO_JSON(OLD));
		RETURN NEW;
	ELSIF TG_OP = 'DELETE'
	THEN
		INSERT INTO changelog
			(table_name, operation, old_val)
		VALUES (TG_RELNAME, TG_OP, ROW_TO_JSON(OLD));
		RETURN OLD;
	END IF;
END;
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

CREATE TRIGGER users_changelog_biudt
	BEFORE INSERT OR UPDATE OR DELETE
	ON users
	FOR EACH ROW
EXECUTE PROCEDURE logchange();
```
