# MCP server for neo4j
This folder hosts the source code and stack to deploy a neo4j MCP stack.

## Conventions
- `src` folder contains the git repo for the neo4j MCP server (https://github.com/neo4j-contrib/mcp-neo4j).
- `stacks` folder contains the deployment of the neo4j MCP server.
- `configs` folder contains all the config for the AI agents to connect to the MCP server.

## How Tos
### Run MCP locally
- First make sure local k8s deployment of neo4j is running with localhost:7687 exposed for port-forwarding and connecting to neo4j DB.
- Run `./deploy.sh` to deploy all MCP servers to k8s in the same namespace as neo4j DB.
- Run all the port forwarding commands in the `deploy.sh` file to expose the MCP servers to local AI agent.
- Copy the contents of `settings.json` from the `configs` folder for the respective AI agent being used.
- Start the AI agent and test command like `Add 5 actors to the neo4j database and make them have relations with producers and the film they worked on.`. Then test with `MATCH (n)-[r]->(m) RETURN n, r, m` in the browser.