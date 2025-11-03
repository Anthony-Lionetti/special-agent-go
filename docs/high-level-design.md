# System Architecture

## Overview

This document describes the architecture for a chat application with advanced research capabilities. The system allows users to engage in both standard chat interactions and agent-driven research queries that can run for extended periods.

## Core Components

### 1. API Gateway

The main entry point for all user interactions, handling:

- Chat session management
- Message routing
- Authentication
- File uploads for research queries

### 2. MongoDB

Primary data store for:

- User information
- Chat sessions and message history
- Research run data

### 3. LLM Inference Service

Handles natural language processing for:

- Standard chat responses
- Initial query processing

### 4. Temporal Server & Worker Agents

Orchestrates long-running research tasks:

- **Temporal Server**: Manages workflow orchestration and task distribution
- **Worker Agents**: Execute research tasks asynchronously
- Self-healing capabilities for fault tolerance

## Key Features

### Functional Capabilities

- **Chat Management**: Users can create, view, and delete chat sessions
- **Research Mode**: Toggle between standard chat and research query modes
- **File Upload**: Support for uploading files to enhance research queries
- **Message Editing**: Edit recent messages and chat history
- **Authentication**: Secure user account management

### Non-Functional Requirements

- **Performance**:
  - Chat sessions load in <500ms
  - Files processed in <10s
  - Research runs complete in <15 minutes
- **Reliability**:
  - Availability prioritized over consistency
  - Self-healing agent runs during failures

## API Endpoints

### Chat Session Management

- `POST /chat/session` - Create new chat session
- `GET /chat/{session_id}` - Retrieve chat history
- `DELETE /chat/{session_id}` - Delete chat session

### Messaging

- `POST /chat/{session_id}` - Send standard chat message
- `POST /chat/{session_id}/research` - Initiate research query

## Architecture Pattern

The system follows a microservices architecture with:

- **Synchronous operations** for standard chat (API → LLM Inference)
- **Asynchronous processing** for research queries (API → Temporal → Workers)
- **Event-driven workflows** for long-running research tasks

This design ensures responsive user interactions while supporting complex, time-intensive research operations in the background.
