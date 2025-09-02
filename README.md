# ClickHouse dbt playground

This repository contains a simple dbt project that connects to a ClickHouse database. It is intended for learning and experimentation purposes.

## Running the project

### Requirements
- Docker
- Docker Compose
- Python 3.x (for dbt CLI, if needed)

### Running
Execute: `docker-compose up --build` to start the dbt project. 
This will set up a ClickHouse container and run dbt commands.

Visit `http://localhost:8123` to access the ClickHouse web interface.
