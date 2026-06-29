# ⚡ AI Job Tracker

> Agentic AI system that automatically scrapes, analyses, and displays
> Data Science / AI / ML job listings using **CrewAI + Groq + Flask + Supabase**.

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     APScheduler (24h)                    │
└──────────────────────────┬──────────────────────────────┘
                           │ triggers
┌──────────────────────────▼──────────────────────────────┐
│                    CrewAI Pipeline                       │
│                                                          │
│  [SerpApi/RemoteOK]                                      │
│       ↓ raw jobs                                         │
│  Scraper Agent  →  Summarizer Agent  →  Validator Agent  │
│  (clean data)      (skills + summary)   (validate + tag) │
│                                              ↓ JSON      │
└──────────────────────────────────────────────┬──────────┘
                                               │ upsert
                                    ┌──────────▼──────────┐
                                    │  Supabase (Postgres) │
                                    │  jobs, skills, runs  │
                                    └──────────┬──────────┘
                                               │ query
                              ┌────────────────▼─────────┐
                              │       Flask Web App       │
                              │  /          – job list    │
                              │  /job/<id>  – detail      │
                              │  /dashboard – charts      │
                              └──────────────────────────┘
```
