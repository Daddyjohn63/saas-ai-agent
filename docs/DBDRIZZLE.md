# Drizzle ORM Implementation with PostgreSQL

This document details how Drizzle ORM is implemented and configured to connect to a PostgreSQL database hosted on a VPS server in this project.

## Overview

This project uses **Drizzle ORM** as the database toolkit to interact with a self-hosted PostgreSQL database on a VPS server. Drizzle provides type-safe database queries with minimal overhead.

## Dependencies

The following packages are used for the Drizzle implementation:

```json
{
  "dependencies": {
    "drizzle-orm": "^0.44.2",
    "pg": "^8.16.0",
    "dotenv": "^16.5.0"
  },
  "devDependencies": {
    "drizzle-kit": "^0.31.1",
    "@types/pg": "^8.15.4"
  }
}
```

- **drizzle-orm**: The core ORM library
- **pg**: Node.js PostgreSQL client (node-postgres driver)
- **drizzle-kit**: CLI tool for database migrations and studio
- **dotenv**: Environment variable management

## Configuration Files

### 1. Drizzle Configuration (`drizzle.config.ts`)

Location: `./drizzle.config.ts`

```typescript
import 'dotenv/config';
import { defineConfig } from 'drizzle-kit';

export default defineConfig({
  out: './drizzle',
  schema: './src/db/schema.ts',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL!
  }
});
```

**Configuration Breakdown:**

- `out`: Directory where migration files are generated (`./drizzle`)
- `schema`: Path to the database schema definition (`./src/db/schema.ts`)
- `dialect`: Database type - `postgresql` for Supabase
- `dbCredentials.url`: Supabase PostgreSQL connection string from environment variables

### 2. Database Connection (`src/db/index.ts`)

Location: `./src/db/index.ts`

```typescript
import 'dotenv/config';
import { drizzle } from 'drizzle-orm/node-postgres';

export const db = drizzle(process.env.DATABASE_URL!);
```

**Connection Breakdown:**

- Uses `drizzle-orm/node-postgres` driver for PostgreSQL
- Creates a direct connection using the `DATABASE_URL` environment variable
- Exports a single `db` instance used throughout the application
- The connection is lightweight and doesn't require explicit pooling setup (handled by Drizzle internally)

### 3. Database Schema (`src/db/schema.ts`)

Location: `./src/db/schema.ts`

The schema defines the following tables:

#### **User Table**

```typescript
user: {
  id: text(PK);
  name: text;
  email: text(unique);
  emailVerified: boolean;
  image: text;
  createdAt: timestamp;
  updatedAt: timestamp;
}
```

#### **Session Table**

```typescript
session: {
  id: text (PK)
  expiresAt: timestamp
  token: text (unique)
  createdAt: timestamp
  updatedAt: timestamp
  ipAddress: text
  userAgent: text
  userId: text (FK -> user.id, cascade delete)
}
```

#### **Account Table**

```typescript
account: {
  id: text (PK)
  accountId: text
  providerId: text
  userId: text (FK -> user.id, cascade delete)
  accessToken: text
  refreshToken: text
  idToken: text
  accessTokenExpiresAt: timestamp
  refreshTokenExpiresAt: timestamp
  scope: text
  password: text
  createdAt: timestamp
  updatedAt: timestamp
}
```

#### **Verification Table**

```typescript
verification: {
  id: text(PK);
  identifier: text;
  value: text;
  expiresAt: timestamp;
  createdAt: timestamp;
  updatedAt: timestamp;
}
```

#### **Agents Table**

```typescript
agents: {
  id: text (PK, auto-generated with nanoid)
  name: text
  userId: text (FK -> user.id, cascade delete)
  instructions: text
  createdAt: timestamp (default: now)
  updatedAt: timestamp (default: now)
}
```

#### **Meetings Table**

```typescript
meetings: {
  id: text (PK, auto-generated with nanoid)
  name: text
  userId: text (FK -> user.id, cascade delete)
  agentId: text (FK -> agents.id, cascade delete)
  status: enum (upcoming|active|completed|processing|cancelled)
  startedAt: timestamp
  endedAt: timestamp
  transcriptUrl: text
  recordingUrl: text
  summary: text
  createdAt: timestamp (default: now)
  updatedAt: timestamp (default: now)
}
```

**Schema Features:**

- Uses `pgTable` for PostgreSQL table definitions
- Uses `pgEnum` for enumerated types (meeting_status)
- Implements foreign key relationships with cascade deletes
- Uses `nanoid` for generating unique IDs
- Includes automatic timestamps with `defaultNow()` and `$defaultFn()`

## Environment Variables

Required environment variable in `.env` or `.env.local`:

```env
DATABASE_URL=postgresql://[user]:[password]@[host]:[port]/[database]
```

For a self-hosted VPS PostgreSQL database, the URL typically follows this pattern:

```env
DATABASE_URL=postgresql://postgres:yourpassword@your-vps-ip:5432/your_database
```

Or with a domain name:

```env
DATABASE_URL=postgresql://postgres:yourpassword@yourdomain.com:5432/your_database
```

**Connection String Components:**

- `user`: PostgreSQL username (default: `postgres`)
- `password`: Your PostgreSQL user password
- `host`: Your VPS IP address or domain name
- `port`: PostgreSQL port (default: `5432`)
- `database`: The specific database name to connect to

## VPS PostgreSQL Setup

### Basic VPS Configuration:

To ensure your VPS PostgreSQL server is properly configured to accept connections:

1. **Install PostgreSQL** (if not already installed):

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install postgresql postgresql-contrib

# Check version
psql --version
```

2. **Configure PostgreSQL to Accept Remote Connections**:

Edit `postgresql.conf`:

```bash
sudo nano /etc/postgresql/[version]/main/postgresql.conf
```

Find and modify:

```
listen_addresses = '*'  # or specify your app server IP
```

3. **Configure Client Authentication**:

Edit `pg_hba.conf`:

```bash
sudo nano /etc/postgresql/[version]/main/pg_hba.conf
```

Add a line to allow connections (replace with your app's IP):

```
# Allow connections from specific IP
host    all             all             YOUR_APP_IP/32          md5

# Or allow from any IP (less secure, for development only)
host    all             all             0.0.0.0/0               md5
```

4. **Restart PostgreSQL**:

```bash
sudo systemctl restart postgresql
```

5. **Configure Firewall**:

```bash
# UFW (Ubuntu)
sudo ufw allow 5432/tcp

# Or limit to specific IP
sudo ufw allow from YOUR_APP_IP to any port 5432
```

6. **Create Database and User**:

```bash
sudo -u postgres psql

# In psql shell:
CREATE DATABASE your_database;
CREATE USER your_user WITH ENCRYPTED PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE your_database TO your_user;
\q
```

## NPM Scripts

Available database commands defined in `package.json`:

```json
{
  "scripts": {
    "db:push": "drizzle-kit push",
    "db:studio": "drizzle-kit studio"
  }
}
```

### Commands Explanation:

- **`npm run db:push`**: Pushes schema changes directly to the database without generating migration files (useful for development)
- **`npm run db:studio`**: Opens Drizzle Studio - a visual database browser at `https://local.drizzle.studio`

## Usage in Application

### Basic Query Examples

```typescript
import { db } from '@/db';
import { user, agents, meetings } from '@/db/schema';
import { eq } from 'drizzle-orm';

// Select all users
const users = await db.select().from(user);

// Select user by email
const userByEmail = await db
  .select()
  .from(user)
  .where(eq(user.email, 'user@example.com'));

// Insert a new agent
const newAgent = await db
  .insert(agents)
  .values({
    name: 'My Agent',
    userId: 'user-123',
    instructions: 'Agent instructions here'
  })
  .returning();

// Update agent
await db
  .update(agents)
  .set({ name: 'Updated Agent Name' })
  .where(eq(agents.id, 'agent-123'));

// Delete agent (cascades to meetings)
await db.delete(agents).where(eq(agents.id, 'agent-123'));

// Join queries
const meetingsWithAgents = await db
  .select()
  .from(meetings)
  .leftJoin(agents, eq(meetings.agentId, agents.id))
  .where(eq(meetings.userId, 'user-123'));
```

## Architecture Decisions

### Why Node-Postgres Driver?

The `node-postgres` driver is used instead of other options because:

- **Mature and stable**: Battle-tested PostgreSQL driver for Node.js
- **Direct connection**: Works seamlessly with self-hosted PostgreSQL servers
- **Performance**: Lightweight and fast for both serverless and traditional environments
- **TypeScript support**: Excellent type definitions available
- **Connection pooling**: Built-in connection pooling for optimal performance

### Why Drizzle ORM?

- **Type Safety**: Full TypeScript support with inferred types
- **Lightweight**: Minimal runtime overhead compared to heavier ORMs
- **SQL-like**: Query syntax closely mirrors SQL, making it easy to learn
- **Migration Control**: Flexibility with both push and migration workflows
- **No Schema Drift**: Schema is defined in code and pushed to database
- **Serverless Friendly**: Works well with Next.js and edge runtimes

## Database Workflow

### Development Workflow:

1. **Modify Schema**: Edit `src/db/schema.ts`
2. **Push Changes**: Run `npm run db:push` to apply changes to Supabase
3. **Visual Inspection**: Use `npm run db:studio` to browse data

### Production Workflow:

For production, consider using proper migrations instead of push:

```bash
# Generate migration
npx drizzle-kit generate

# Apply migration
npx drizzle-kit migrate
```

## Connection Details

- **Driver**: `drizzle-orm/node-postgres`
- **Connection Method**: Direct connection string to VPS PostgreSQL server
- **Pooling**: Managed by node-postgres driver's built-in connection pool
- **SSL**: Optional - can be configured via connection string parameters if needed
- **Connection Type**: Single instance exported from `src/db/index.ts`
- **VPS Requirements**: PostgreSQL 12+ installed and running on VPS
- **Network**: Ensure PostgreSQL port (5432) is accessible from your application server

## Security Considerations

- **Environment Variables**: Database credentials are stored in environment variables, never hardcoded
- **Version Control**: Never commit `.env` files to version control
- **Firewall**: Configure VPS firewall to restrict PostgreSQL port access to trusted IPs only
- **SSL/TLS**: Consider enabling SSL connections for production (add `?sslmode=require` to connection string)
- **Strong Passwords**: Use strong, unique passwords for PostgreSQL users
- **User Privileges**: Use dedicated database users with minimal required privileges, not the postgres superuser
- **Database Constraints**: Foreign key constraints enforce referential integrity
- **Cascade Deletes**: Configured cascade deletes ensure orphaned records are cleaned up
- **Regular Backups**: Implement automated backups on your VPS (pg_dump, pg_basebackup)
- **Network Security**: Consider using VPN or SSH tunneling for connections from development machines

## Troubleshooting

### Connection Issues:

- **Verify Connection String**: Ensure `DATABASE_URL` is set correctly with proper credentials
- **PostgreSQL Service**: Check that PostgreSQL is running on your VPS (`sudo systemctl status postgresql`)
- **Firewall Rules**: Verify VPS firewall allows connections on port 5432
- **PostgreSQL Configuration**: Check `postgresql.conf` has `listen_addresses` set appropriately
- **pg_hba.conf**: Ensure `pg_hba.conf` allows connections from your application's IP address
- **Network Connectivity**: Test connection with `psql` or `telnet your-vps-ip 5432`
- **DNS Resolution**: If using domain name, verify it resolves correctly

### Schema Push Failures:

- **Conflicting Data**: Check for existing data that violates new constraints
- **Foreign Keys**: Verify foreign key relationships reference valid tables/columns
- **Column Types**: Ensure column types are compatible with existing data
- **Permissions**: Verify database user has CREATE/ALTER permissions
- **Lock Issues**: Check for long-running transactions that might lock tables

### Type Errors:

- **Regenerate Types**: Restart TypeScript server in your IDE
- **Version Mismatch**: Ensure `drizzle-orm` version matches `drizzle-kit` version
- **Schema Sync**: Make sure schema file matches actual database structure

### Performance Issues:

- **Connection Pool**: Monitor active connections with `SELECT * FROM pg_stat_activity;`
- **Indexes**: Add indexes for frequently queried columns
- **Query Analysis**: Use `EXPLAIN ANALYZE` to optimize slow queries
- **VPS Resources**: Monitor VPS CPU/RAM usage during database operations
