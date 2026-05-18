# Comments & Notifications App (Rails 8)

A simple Rails 8 application for creating comments with user mentions and notifications system.

---

## Tech Stack

- Ruby on Rails 8
- PostgreSQL
- Devise (authentication)
- Meilisearch (search engine)
- Turbo / Hotwire
- Stimulus
- TailwindCSS
- RSpec (testing)
- FactoryBot / Faker

---

## Features

### Authentication
- User registration and login (Devise)
- Multiple users support

### Comments
- Create, edit, delete comments
- Each comment belongs to a user
- Mentions support using `@username`

### Mentions & Notifications
- When a user is mentioned in a comment, a notification is created automatically
- Notifications list for each user
- Mark notifications as read
- Real-time UI updates via Turbo Streams

### Search
- Full-text search for comments using Meilisearch
- Search by comment body

---

## Search Engine (Meilisearch)

This project uses Meilisearch for indexing comments.

Make sure Meilisearch is running locally:

```bash
meilisearch
