# sqitch-ified version of postgraphql tutorial

Worked through and sqitch-ified
https://github.com/postgraphql/postgraphql/blob/master/examples/forum/TUTORIAL.md

# Requirements

I chose not to create a role for the database user inside of sqitch.
You should make it externally before running these.


```
create role forum_example_postgraphql login password 'some clever password';
```
