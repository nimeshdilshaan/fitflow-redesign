# Weighted Technology Stack Decision Matrix

Three candidate stacks were scored 1 (poor) to 5 (excellent) across seven
weighted criteria (weights sum to 100%).

| Criteria (Weight)              | Stack A (Flutter+NestJS+FastAPI+Postgres/Mongo+Firebase Auth) | Stack B (React Native+NestJS+Firestore) | Stack C (Native Kotlin/Swift+Go+DynamoDB+Cognito) |
|---------------------------------|:---:|:---:|:---:|
| Performance (15%)               | 4 | 3 | 5 |
| Scalability (15%)               | 4 | 3 | 5 |
| Development Speed (15%)         | 5 | 5 | 2 |
| Security / Compliance (15%)     | 4 | 3 | 5 |
| Cost (10%)                      | 4 | 3 | 3 |
| AI/ML Support (15%)             | 5 | 3 | 3 |
| Maintainability (15%)           | 4 | 4 | 3 |
| **Weighted Total (/5.00)**      | **4.30** | 3.45 | 3.75 |
| **Rank**                        | **1st** | 3rd | 2nd |

**Recommended stack: A** — highest overall score, balancing performance,
AI/ML support and maintainability for a mid-sized team. Full rationale in
Lab Exercise 05 (Activity 3) and `docs/adr/ADR-001-tech-stack.md`.
