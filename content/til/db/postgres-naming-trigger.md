---
layout: post
title: "Postgres Naming Trigger"
date: 2021-02-02T13:55:44+01:00
language: en
comments: true
tags: 
description: 
keywords: 
draft: false
---

Taken From https://severalnines.com/database-blog/postgresql-triggers-and-stored-function-basics

Pattern `[TBALE_NAME]_[FUNCITON NAME]_[WHEN][1 or more WHY][t]`

When:
* b - Before
* a - After
* i - Instead of 

WHY:
* i - Insert
* u - Update
* d - Delete
* t - Truncate

t = 'trigger'

eg: `my_table_update_ts_biut` means it's a trigger on my_table, triggers update_ts before insert & update

Reasoning: Just by looking at the trigger name, you know which table, and when it is triggered

example

```
-- function to update updated_at column during insert or update
CREATE OR REPLACE FUNCTION update_timestamp()
	RETURNS trigger AS
$$
BEGIN
	NEW.updated_at := NOW();
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER users_update_timestamp_biut
	BEFORE INSERT OR UPDATE
	ON users
	FOR EACH ROW
EXECUTE PROCEDURE update_timestamp();
```
