WSO2 Distributed Deployment with Docker & Docker Compose

This project provides a containerized WSO2 deployment with three main nodes—API Manager, External Gateway, and Identity Server (Key Manager)—all backed by a MySQL database for persistent storage.

Components
Service	Version	Role
MySQL	Latest stable	Shared WSO2 databases (user, registry, etc.)
WSO2 API Manager	3.2.0	Publisher / Store / Traffic Manager
WSO2 External Gateway	3.2.0	API Gateway node
WSO2 Identity Server	5.10.0	Acts as Key Manager for API Manager
Directory Layout
├─ control/
│   └─ deployment.toml          # Control plane config
├─ database-init/
│   ├─ amysql.sql               # Initial schemas
│   └─ bmysql.sql
├─ gateway/
│   └─ deployment.toml          # Gateway custom config
├─ is/
│   └─ deployment.toml          # Identity Server custom config
├─ wso2apim/
│   └─ Dockerfile               # API Manager image
├─ wso2gateway/
│   ├─ Dockerfile               # Gateway image
│   └─ gateway-entrypoint.sh
├─ wso2is/
│   └─ Dockerfile               # Identity Server image
├─ docker-compose.yml
└─ README.md


Each WSO2 node mounts its own deployment.toml for custom configuration and attaches persistent volumes for data.

Prerequisites

Docker ≥ 20.x

Docker Compose ≥ 2.x

At least 4 GB RAM and 2 CPU cores free

Build the Images

From the repository root:

docker build -t wso2/apim:3.2.0 ./wso2apim
docker build -t wso2/gateway:3.2.0 ./wso2gateway
docker build -t wso2/is:5.10.0 ./wso2is

Configuration

Database

SQL initialization scripts are in database-init/.

Update credentials or schema names inside docker-compose.yml if needed.

Custom Deployment

Edit the respective deployment.toml under control/, gateway/, or is/ to match your environment (hostnames, DB URLs, etc.).

Volumes

Docker volumes are declared in docker-compose.yml for:

Persistent MySQL data

Persistent WSO2 artifacts (repository/deployment, logs, etc.)

Mounting custom deployment.toml files into each container

Start the Cluster
docker-compose up -d


This will:

Launch a MySQL container

Launch the API Manager, Gateway, and Identity Server containers

Network them together on a common Docker network

The first startup may take a few minutes while databases initialize.

Access Points
Service	URL (default)
API Manager Publisher	http://localhost:9443/publisher

API Manager Dev Portal	http://localhost:9443/devportal

External Gateway	http://localhost:8243/

Identity Server Console	http://localhost:9444/carbon

MySQL	localhost:3306

Adjust host ports in docker-compose.yml if needed.

Data Persistence

MySQL data → mysql_data volume

WSO2 shared data → individual volumes per node

Custom configs (deployment.toml) are mounted read-only from the repo so changes are version-controlled.

Stopping & Cleanup
docker-compose down      
docker-compose down -v    

Notes

Ensure the JDBC URLs in each deployment.toml match the MySQL container service name (e.g., jdbc:mysql://mysql:3306/...).

Scale gateway nodes if needed by running docker-compose up -d --scale wso2gateway=2.

For production, secure DB credentials using Docker secrets or environment variables.
