# Postgres to dynamo using aws datapipeline

This project is a demo on how to import some data from postgres running on RDS to Dynamo using AWS data pipeline.

The flow is as follows:

(1) Data in Postgres -> (2) data in CSV on S3 -> (3) Hive Job to transform CSV to Dynamo Format -> (4) Dynamo

Steps 1,2 are done by the pipeline "postgres-to-S3"

Steps 3,4 are done by the pipeline "s3-to-dynamo"

The demo example is we have the following tables in postgres:

```
create table department (id bigint not null, name varchar(30) not null, primary key (id));

create table employee (id bigint not null, name varchar(30) not null, department_id bigint not null, primary key(id), foreign key(department_id) references department(id));
```

with some data and we want to move this to dynamo in the following format: `id|employee|department`.

How to run the script:

Prerequisites:

* Create a postgres RDS database and commands in the script under `sql-scripts\init-db.sql` to create the database and add some test data
* Create a S3 bucket with folders for storing the CSV export and logs from the pipeline job


postgres-to-S3:
* Edit the json definition under `postgres-to-s3`. Things to look out for:

** Replace the bucket name, database url and credentials with appropriate values as created in the previous steps. (search for REPLACE in the json file).
** The EC2 resource needs to be able to reach the database, create the appropriate security group and replace the name in the json.

* Create the pipeline and run it.

s3-to-dynamo:

* Create a dynamo table for output with a single key "id" of type String.
* Edit the json definition under `s3-to-dynamo`.

The implementation is based on this [stackoverflow thread](https://stackoverflow.com/questions/38712288/convert-csv-to-required-format-for-import-into-dynamodb-using-aws-datapipeline) and this [sample](https://github.com/aws-samples/data-pipeline-samples/tree/master/samples/DynamoDBImportCSV).

* Replace as per the above, make sure the S3 patch between the previous and this step match.

## TODO:

* Merge into a single pipeline
* Use parameters in AWS template
* Write some scripts for provisioning the db and the dynamo table