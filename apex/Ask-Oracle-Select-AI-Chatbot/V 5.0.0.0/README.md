# Ask Oracle Select AI 5.0

Ask Oracle Select AI is an Oracle APEX application that provides a low-code interface to Oracle Select AI on Oracle AI Database and Autonomous AI Database. It brings conversational AI, natural-language-to-SQL (NL2SQL), Retrieval-Augmented Generation (RAG), charting, and agent experiences into one application that you can inspect, customize, and extend.

Release 5.0 evolves the original conversational interface into a low-code application platform for configuring, governing, and deploying Select AI-powered experiences.

## What's new in Release 5.0

- Visual Agent Builder for Oracle Select AI Agent Framework agents and teams
- Agent Team Map for inspecting agent, task, and tool relationships
- Prebuilt Oracle Select AI agents that can be installed and customized in the application
- Natural-language chart generation and more suitable fallback displays
- AI Profile lifecycle management for NL2SQL, RAG, and agents
- Centralized governance, defaults, branding, and button-level access controls

## Why use Release 5.0?

Release 5.0 helps teams move from asking questions to building governed AI applications. Use it to configure NL2SQL and RAG profiles, build and validate agent teams visually, generate charts from natural-language prompts, and control the capabilities available to different users.

## Key capabilities

- **Chat** — converse directly with the LLM configured in an AI Profile.
- **NL2SQL** — query Oracle AI Database using natural language and explain generated SQL.
- **RAG** — ground responses in trusted text content using Retrieval-Augmented Generation and Oracle AI Vector Search.
- **Agents and teams** — run Oracle Select AI Agent Framework agents and agent teams.
- **Visual Agent Builder** — generate an initial team from natural language, then refine its teams, agents, tasks, and tools in one visual workflow before validating it.
- **Agent Team Map** — view routing and relationships among teams, agents, tasks, and tools.
- **Charts** — request visualizations in natural language. If the requested chart does not fit the returned data shape, Ask Oracle can use a more appropriate display, such as a table or alternate chart type.
- **Profiles and governance** — create, edit, validate, and reuse AI Profiles; configure application defaults, branding, and feature access.
- **Conversations** — organize conversation history and optionally use text-to-speech for responses.

## Screenshots

![Agent Builder showing an agent team with its agents, tasks, and assigned tools](../../images/agent_builder.png)

![Agent Team Map showing relationships among teams, agents, tasks, and tools](../../images/agent_team_map.png)

![Chart generation displaying a visualization produced from a natural-language prompt](../../images/chart_generation.png)

![AI Profile management screen for configuring an NL2SQL profile](../../images/nl2sql_profile.png)

## Repository contents

| Path | Purpose |
| --- | --- |
| [`ADB-AskOracle-Chatbot-2026-07-23.sql`](ADB-AskOracle-Chatbot-2026-07-23.sql) | Oracle APEX application export for Ask Oracle Select AI Release 5.0. It includes supporting objects. |
| `README.md` | This overview, setup guidance, and troubleshooting notes. |

Prebuilt agent definitions and README image assets are not separate files in this repository. Use the application interface after import to browse and manage the prebuilt agents provided by the application.

## Prerequisites

Before importing the application, make sure you have the following:

- An Oracle AI Database or Autonomous AI Database environment with Oracle APEX and Oracle Select AI available. The exported application was generated with Oracle APEX **24.2.17**; import it into a compatible APEX environment.
- An APEX workspace and parsing schema. Import the export as that schema, or use a database account with `APEX_ADMINISTRATOR_ROLE`.
- A configured Select AI provider credential, supported model, and AI Profile. The profile must be usable by the application's parsing schema.
- For NL2SQL, access to the schemas and objects you intend to query.
- For RAG, a configured embedding model and an Oracle AI Vector Search vector index containing the content to retrieve.
- For agent experiences, the required Oracle Select AI Agent Framework configuration and an agent team selected in the application.

Grant only the database privileges needed by the parsing schema and the users of the application. The exact grants depend on your database, provider, selected AI capabilities, and the data you expose. Consult your database administrator and the Oracle Select AI documentation before granting access to production data.

## Installation

1. Download or clone this repository and locate [`ADB-AskOracle-Chatbot-2026-07-23.sql`](ADB-AskOracle-Chatbot-2026-07-23.sql).
2. Sign in to the target Oracle APEX workspace as a workspace administrator or developer with permission to import applications.
3. Open **App Builder**, select **Import**, choose the SQL export, and complete the import wizard. Choose the target parsing schema when prompted.
4. Review the supporting-object installation during the import. The application export includes supporting objects; allow the import to install them when appropriate for your environment.
5. Open the imported application and configure its Select AI Profiles, conversation defaults, and access controls. Configure RAG profiles and vector indexes only if you plan to use RAG; configure an agent team only if you plan to use agents.
6. Run the application and complete the validation checks below.

For an illustrated import procedure, [watch the installation video on YouTube](https://youtu.be/kjeQ2AC3TFo). The local [MP4 copy](https://github.com/sandeepkhot/oracle-autonomous-database-samples/blob/main/apex/images/Ask%20Oracle%20App%20Installation%20video.mp4) is provided for download; GitHub does not reliably provide in-page MP4 playback for repository README content.

## Configuration

Configure the application before making it available to end users:

- **AI Profiles:** Create or select the profiles for Chat, NL2SQL, RAG, and agents. Validate the provider credential, model, and profile settings.
- **Conversation defaults:** Choose the default conversation mode and the default NL2SQL Profile, RAG Profile, and optional Agent Team.
- **RAG:** Set the embedding model, Oracle AI Vector Search vector index, and retrieval settings. Load and index your trusted content before testing retrieval.
- **Agents:** Use Agent Builder to create or refine teams, agents, tasks, and tools; validate the team before assigning it as a default.
- **Governance:** Set application name, logo, branding, navigation, and permissions for actions such as SQL Editor, exports, deletion, conversation timer, and agent reasoning.

## Quick start and validation

After configuration, verify each enabled capability with a prompt appropriate for your data:

| Capability | Example validation |
| --- | --- |
| Chat | Ask a general question supported by the configured model. |
| NL2SQL | Ask a question about a table the parsing schema can query, such as “How many orders were created this month?” |
| RAG | Ask a question answered by content you have loaded into the configured vector index. |
| Agents | Select an agent team and ask it to complete a task that uses its configured tools. |
| Charts | Ask “Show monthly sales as a line chart.” Confirm that a chart, table, or another suitable display is returned. |

## Troubleshooting

| Symptom | What to check |
| --- | --- |
| No AI Profile is available | Create or grant access to a Select AI Profile for the parsing schema, then select it in the application defaults. |
| Provider, credential, or model error | Verify the provider credential, model name and availability, network policy, and the profile configuration. |
| NL2SQL cannot query data | Verify grants and synonyms for the parsing schema, and confirm the profile is configured for the intended schemas and objects. |
| RAG returns no relevant results | Confirm the correct embedding model, vector index, indexed content, and retrieval settings are configured. |
| Agent option is unavailable or fails | Confirm Agent Framework configuration, validate the agent team, and select the team in the conversation settings. |
| A chart is not shown | Confirm the prompt and result are suitable for a visualization; Ask Oracle may deliberately return a table or alternate chart when the requested shape is unsuitable. |
| A button or feature is missing | Review the application's action controls and button-level access settings for the current user. |

## Resources

- [Oracle Autonomous AI Database Select AI](https://www.oracle.com/autonomous-database/select-ai/)
- [Getting started with Select AI](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/select-ai-get-started.html)
- [Manage AI Profiles](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/select-ai-manage-profiles.html)
- [Oracle Select AI Agent Framework](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/select-ai-agent.html)
- [Oracle APEX](https://apex.oracle.com/)
- [Oracle APEX in Autonomous AI Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-express-autonomous-database.html)

## License

Copyright (c) 2026 Oracle and/or its affiliates.

Licensed under the [Universal Permissive License (UPL), Version 1.0](https://oss.oracle.com/licenses/upl/).
