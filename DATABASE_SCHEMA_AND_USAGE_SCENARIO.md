# Database Schema & Usage Scenario

## Relational Structure

### users

| Column     | Type         | Constraints      | Description           |
| ---------- | ------------ | ---------------- | --------------------- |
| id         | SERIAL       | PRIMARY KEY      | Unique user ID        |
| email      | VARCHAR(255) | UNIQUE, NOT NULL | User email address    |
| password   | VARCHAR(255) | NOT NULL         | Hashed password       |
| name       | VARCHAR(100) |                  | Display name          |
| created_at | TIMESTAMP    | DEFAULT now()    | Account creation time |

---

### trips

| Column     | Type         | Constraints          | Description        |
| ---------- | ------------ | -------------------- | ------------------ |
| id         | SERIAL       | PRIMARY KEY          | Unique trip ID     |
| user_id    | INTEGER      | REFERENCES users(id) | Creator's user ID  |
| name       | VARCHAR(100) | NOT NULL             | Trip name/title    |
| start_date | DATE         | NOT NULL             | Trip start date    |
| end_date   | DATE         | NOT NULL             | Trip end date      |
| created_at | TIMESTAMP    | DEFAULT now()        | Trip creation time |

---

### activity_days

| Column      | Type    | Constraints          | Description                                 |
| ----------- | ------- | -------------------- | ------------------------------------------- |
| id          | SERIAL  | PRIMARY KEY          | Unique day ID                               |
| trip_id     | INTEGER | REFERENCES trips(id) | Associated trip                             |
| date        | DATE    | NOT NULL             | Date of activities                          |
| day_details | TEXT    |                      | Notes, plans, or travel details for the day |

---

### activities

| Column          | Type         | Constraints                  | Description        |
| --------------- | ------------ | ---------------------------- | ------------------ |
| id              | SERIAL       | PRIMARY KEY                  | Unique activity ID |
| activity_day_id | INTEGER      | REFERENCES activity_days(id) | Associated day     |
| name            | VARCHAR(100) | NOT NULL                     | Activity name      |
| description     | TEXT         |                              | Activity details   |
| time            | TIME         |                              | Time of activity   |
| location        | VARCHAR(255) |                              | Activity location  |

---

### trip_users

| Column  | Type    | Constraints          | Description      |
| ------- | ------- | -------------------- | ---------------- |
| id      | SERIAL  | PRIMARY KEY          | Unique row ID    |
| trip_id | INTEGER | REFERENCES trips(id) | Shared trip      |
| user_id | INTEGER | REFERENCES users(id) | User with access |

---

## Relationships

- A **user** can have many **trips**.
- A **trip** can have many **activity_days**.
- An **activity_day** can have many **activities**.
- A **trip** can be shared with many **users** (via `trip_users`).
- A **user** can have access to many **trips** (via `trip_users`).

---

## Example Usage Scenario

1. **User Registration & Login**

   - A new user signs up with their email, password, and name.
   - Their info is stored in the `users` table.

2. **Creating a Trip**

   - The user creates a new trip called “Italy Adventure,” specifying start and end dates.
   - A new row is added to the `trips` table, linked to the user’s `id`.

3. **Adding Days to the Trip**

   - The user adds days to their trip (e.g., May 10, May 11, May 12).
   - Each day is a row in `activity_days`, linked to the trip’s `id`.
   - The user can add notes or plans for each day using the `day_details` field.

4. **Adding Activities to Each Day**

   - For May 10, the user adds:
     - “Visit Colosseum” at 10:00 AM, location: Rome
     - “Lunch at Trattoria” at 1:00 PM, location: Rome
   - Each activity is a row in `activities`, linked to the correct `activity_day_id`.

5. **Viewing the Trip**

   - The app queries all `activity_days` for the trip, ordered by date.
   - For each day, it queries all `activities`, ordered by time.

6. **Sharing a Trip**

   - Any user on a trip (including the creator) can invite others to join.
   - All users on a trip have equal permissions: they can create, edit, or delete days and activities.
   - Any user can leave a trip at any time. Leaving removes their access (their row is deleted from `trip_users`).
   - If a trip has no users remaining (i.e., the last user leaves), the trip and all related data are automatically deleted.

   #### Ownership

   - There is no special owner role for trips in the MVP. All users have equal rights.
   - The user who creates the trip is simply the first member.
   - No approval or proposal workflow is enforced; all users can make changes directly.
   - After MVP, the idea of Ownership and User Roles can be revisited.

   #### Future Considerations: Ownership & User Roles

   - The current MVP uses a fully collaborative model where all users have equal permissions on a trip.
   - In the future, the schema and application logic may be extended to support user roles such as **owner**, **editor**, and **viewer**.
   - Ownership could enable features like:
   - Restricting who can edit or delete trips, days, or activities
   - Approval workflows for proposed changes
   - Transferring ownership if the current owner leaves
   - Assigning different permissions to collaborators
   - Any changes to support roles or ownership will require updates to both the database schema (e.g., adding a `role` column to `trip_users`) and the application logic.

---

This schema supports fully collaborative trip planning, where all users have equal permissions. Trips are deleted automatically when no users remain. The structure is designed for efficient queries and easy expansion after MVP.
