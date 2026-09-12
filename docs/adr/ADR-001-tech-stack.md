# ADR-001: Adopt Flutter + NestJS + Polyglot Persistence for the FitFlow Redesign

**Status:** Accepted

**Context:**
FitFlow must deliver a consistent redesigned experience across iOS, Android
and web, driven by AI-personalized workout and nutrition features, while
remaining maintainable for a small-to-mid engineering team on a limited
timeline.

**Decision:**
Use Flutter for a single cross-platform client; NestJS as the primary
backend with a dedicated FastAPI microservice for AI recommendations;
PostgreSQL as the relational system of record, MongoDB for the social feed,
Redis for caching/real-time pub/sub, and Firebase Auth for identity.

**Alternatives Considered:**
- React Native + Firestore-only (Stack B) — faster to prototype but weaker
  AI/data-integrity fit.
- Native Kotlin/Swift + Go + DynamoDB (Stack C) — best raw
  performance/scalability but roughly triples UI maintenance effort and
  slows delivery (no web client).

**Consequences:**
- Positive: one shared UI codebase, a natural home for AI logic,
  relationally consistent core data, low-friction auth.
- Trade-off: the team must operate two databases (PostgreSQL + MongoDB) and
  one extra microservice (FastAPI) rather than a single data store.
