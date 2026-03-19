# RFC Creator Extension

Create technical RFCs (Request for Comments) from feature specs. RFCs capture architectural decisions and trade-offs, sitting between spec and plan in the spec-driven workflow.

## Workflow

```
/speckit.specify  ->  /speckit.rfc.create  ->  /speckit.plan  ->  /speckit.tasks  ->  /speckit.implement
     WHAT/WHY          HOW (decision)          HOW (steps)        WORK ITEMS         CODE
```

## Installation

```bash
specify extension add --dev extensions/rfc
```

## Usage

```bash
# After creating a spec with /speckit.specify
/speckit.rfc.create
# or with tech constraints
/speckit.rfc.create using Go and PostgreSQL
```

## What an RFC Captures

- **Decision Summary**: 2-3 sentence TL;DR
- **Background**: Technical landscape (not business context)
- **Problem**: Why the current system can't meet spec requirements
- **Proposal + Architecture**: Chosen approach with diagrams
- **Alternatives Considered**: What else was evaluated and why rejected
- **Metrics**: Business (from spec) + Technical (implementation-specific)
- **Known Limitations**: Deliberate scope boundaries

## Writing Discipline

The command enforces 8 non-negotiable rules:

1. RFCs are decision documents, not design documents
2. Don't re-explain the business problem (that's in the spec)
3. Don't teach your reviewers
4. Every alternative must have a verdict
5. Diagrams over paragraphs
6. Outstanding questions must be blocking (max 5)
7. Scope to ONE decision
8. Length discipline (Background: 1-2 paragraphs, Problem: 1-3 paragraphs)

## Requirements

- Spec Kit >= 0.2.0
- An existing feature spec (`/speckit.specify` must have been run first)
