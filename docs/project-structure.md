# Research Agent Monorepo Structure

```
research-agent/
├── README.md
├── Makefile                    # Root-level commands for the entire project
├── docker-compose.yml          # Local Temporal server + dependencies
├── .gitignore
│
├── backend/
│   ├── workflows/              # Go workflows
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── worker/
│   │   │   └── main.go        # Workflow worker entry point
│   │   ├── research.go        # Research workflow
│   │   ├── types.go           # Shared types and structs
│   │   └── config.go          # Temporal configuration
│   │
│   ├── activities/             # Python activities
│   │   ├── requirements.txt
│   │   ├── setup.py
│   │   ├── worker.py           # Activity worker
│   │   ├── activities/
│   │   │   ├── __init__.py
│   │   │   ├── web_search.py
│   │   │   ├── summarize.py
│   │   │   └── extract.py
│   │   └── config/
│   │       └── temporal.py
│   │
│   └── api/                    # Go API server
│       ├── go.mod
│       ├── go.sum
│       ├── server/
│       │   └── main.go        # API server entry point
│       ├── handlers.go        # API request handlers
│       ├── temporal.go        # Temporal client
│       └── middleware.go      # CORS and other middleware
│
├── frontend/                   # React frontend
│   ├── package.json
│   ├── package-lock.json
│   ├── vite.config.js          # Using Vite for fast dev
│   ├── index.html
│   ├── src/
│   │   ├── main.jsx
│   │   ├── App.jsx
│   │   ├── components/
│   │   │   ├── ResearchForm.jsx
│   │   │   ├── ResultsView.jsx
│   │   │   └── WorkflowStatus.jsx
│   │   ├── services/
│   │   │   └── api.js
│   │   └── styles/
│   │       └── index.css
│   └── public/
│
├── shared/                     # Shared definitions
│   ├── proto/                  # If using protobuf for schema
│   │   └── research.proto
│   └── schemas/                # Or JSON schemas
│       └── research.json
│
├── scripts/                    # Utility scripts
│   ├── setup.sh               # Initial setup script
│   ├── start-temporal.sh      # Start local Temporal
│   └── run-dev.sh            # Start all services in dev mode
│
└── docs/
    ├── architecture.md
    └── api.md
```

## Key Design Decisions

### 1. **Backend Organization**

- **workflows/**: Go-based Temporal workflows (orchestration logic)
- **activities/**: Python-based activities (actual work: web scraping, AI calls, etc.)
- **api/**: Go REST/GraphQL API server that triggers workflows

### 2. **Frontend (TBD, coming soon)**

- Next.js React frontend
- Separate services layer for API communication
- Component-based structure for research UI
