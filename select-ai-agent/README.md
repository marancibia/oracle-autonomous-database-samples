# About Oracle Select AI Agent Framework

Oracle Select AI Agent Framework extends Oracle Select AI with a database-native framework for building, deploying, running, and managing AI agents in Oracle AI Database, including Oracle Autonomous AI Database. It enables agentic workflows that can reason over prompts, use tools, maintain context, reflect on results, and orchestrate multi-step tasks using the ReAct reasoning-and-acting pattern.

With Oracle Select AI Agent Framework, you can define agent teams, agents, tasks, and tools directly through database-managed capabilities. Agents can use built-in tools such as SQL, RAG, web search, email, and Slack, as well as custom tools based on PL/SQL functions and REST integrations. This enables you to connect LLM reasoning with governed enterprise data, business logic, and operational workflows without standing up a separate agent orchestration stack.

The framework can reduce development and operational overhead because agent creation, execution, monitoring, and history are managed inside the database. Instead of downloading, installing, and operating a separate agent framework or provisioning additional compute for orchestration, you can use database development tooling and database views to define, run, inspect, and monitor agent behavior.

Because agents operate close to the data, Oracle Select AI Agent Framework also strengthens security and governance. Data does not need to be shipped to an external orchestration layer, and agent access can align with established Oracle AI Database controls, including role-based and code-based access control, system and object privileges, Virtual Private Database, Oracle Real Application Security, data masking, encryption, auditing, guardrails, and read-only session controls.

In short, Oracle Select AI Agent Framework enables you to build secure, governed, multi-step AI agents directly in Oracle AI Database, combining LLM reasoning with SQL, RAG, PL/SQL, REST services, memory, monitoring, and enterprise security controls.

---

## Resources

- [Autonomous AI Database Select AI](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/select-ai-about.html)
- [Getting Started with Select AI](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/select-ai-get-started.html)
- [DBMS_CLOUD_AI](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/dbms-cloud-ai-package.html)
- [DBMS_CLOUD_AI_AGENT](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/dbms-cloud-ai-agent-package.html)
- [Blog: Build Your Agentic Solution using Oracle Autonomous AI Database Select AI Agent - an Autonomous Agent Framework](https://blogs.oracle.com/machinelearning/build-your-agentic-solution-using-oracle-adb-select-ai-agent)

---

## Folder Structure

- **sql/**
- **python/**
- **r/**
- **notebooks/**
