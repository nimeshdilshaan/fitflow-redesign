# FitFlow Redesign

Redesign of the FitFlow fitness app, addressing the usability and business
problems identified in the IT3060 HCI case study (declining retention, a
3.8-star app rating, and weak AI/social/nutrition features).

## Tech Stack
- **Frontend:** Flutter (single codebase — iOS, Android, Web)
- **Backend:** NestJS (TypeScript) — modular services for Workout, Nutrition,
  Social and Progress
- **AI Microservice:** Python / FastAPI — personalized workout and nutrition
  recommendations
- **Databases:** PostgreSQL (system of record), MongoDB (social feed/activity
  logs), Redis (cache, sessions, pub/sub)
- **Authentication:** Firebase Auth

See [`docs/tech-stack-summary.md`](docs/tech-stack-summary.md) and
[`docs/comparison-matrix.md`](docs/comparison-matrix.md) for the full
rationale, and [`docs/adr/ADR-001-tech-stack.md`](docs/adr/ADR-001-tech-stack.md)
for the formal decision record.

## Architecture
![Architecture Diagram](docs/architecture-diagram.png)

## Folder Structure

fitflow-redesign/
├── frontend/                # Flutter app (iOS, Android, Web)
├── backend/                 # NestJS API services
├── ai-service/              # FastAPI recommendation engine
├── docs/
│   ├── tech-stack-summary.md
│   ├── comparison-matrix.md
│   ├── architecture-diagram.png
│   └── adr/
│       └── ADR-001-tech-stack.md
├── .github/
│   └── workflows/
│       └── ci.yml
├── .gitignore
├── LICENSE
└── README.md