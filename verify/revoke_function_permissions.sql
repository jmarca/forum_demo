-- Verify forum_demo:revoke_function_permissions on pg

BEGIN;

-- Seems to be a workable attempt to test if execute privs are revoked
-- from public...create a fuction and verify that public cannot
-- execute

create function deleteme_add(a int, b int) returns int as $$
  select a + b
$$ language sql stable;

-- postgres has execute
SELECT 1/count(*) from (select  has_function_privilege('postgres','deleteme_add(int,int)', 'execute') as exec) a where exec;

-- public does not
SELECT 1/count(*) from (select  has_function_privilege('public','deleteme_add(int,int)', 'execute') as exec) a where not exec;

ROLLBACK;
