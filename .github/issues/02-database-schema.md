# Issue #2: Database Schema & Seed Data

**Labels:** `enhancement`, `database`, `mvp`, `priority-high`
**Milestone:** MVP Phase 1
**Estimated Time:** 1 day (8 hours)

## 📋 Description
Design and implement the complete PostgreSQL database schema for the shrtnr application, including Entity Framework Core migrations and seed data for development and testing.

## 🎯 Acceptance Criteria
- [ ] PostgreSQL tables created (users, urls, click_events)
- [ ] Entity Framework Core models and DbContext
- [ ] Database migrations working
- [ ] Seed data for development testing
- [ ] Database indexes for performance
- [ ] Foreign key constraints and relationships
- [ ] Data validation and constraints
- [ ] Connection string configuration

## 🛠️ Technical Requirements
- **PostgreSQL 15+** with UUID support
- **Entity Framework Core 9** with migrations
- **Npgsql** provider for PostgreSQL
- **Data annotations** for validation
- **Fluent API** for complex relationships

## 📝 Database Schema

### Tables Structure
```sql
-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- URLs table
CREATE TABLE urls (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    short_code VARCHAR(10) UNIQUE NOT NULL,
    original_url TEXT NOT NULL,
    user_id UUID REFERENCES users(id),
    title VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);

-- Click events table
CREATE TABLE click_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    url_id UUID NOT NULL REFERENCES urls(id) ON DELETE CASCADE,
    clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address INET,
    user_agent TEXT,
    referer TEXT,
    country_code CHAR(2),
    city VARCHAR(100)
);
```

### Entity Framework Models
- [ ] `User` entity with relationships
- [ ] `Url` entity with validation attributes
- [ ] `ClickEvent` entity for analytics
- [ ] `ShrtnrDbContext` with DbSets and configuration
- [ ] Fluent API configuration for relationships

### Performance Indexes
```sql
CREATE INDEX idx_urls_short_code ON urls(short_code);
CREATE INDEX idx_urls_user_id ON urls(user_id);
CREATE INDEX idx_click_events_url_id ON click_events(url_id);
CREATE INDEX idx_click_events_clicked_at ON click_events(clicked_at);
```

## 🔧 Implementation Tasks

### Entity Framework Setup
- [ ] Install EF Core packages (Npgsql, Design, Tools)
- [ ] Create entity models with data annotations
- [ ] Configure DbContext with connection string
- [ ] Set up dependency injection for DbContext

### Database Migrations
- [ ] Initial migration with all tables
- [ ] Migration for indexes and constraints
- [ ] Seed data migration for development
- [ ] Migration rollback testing

### Seed Data
- [ ] Test users with hashed passwords
- [ ] Sample URLs for development
- [ ] Historical click events for analytics testing
- [ ] Database cleanup and reset scripts

## 📊 Testing Strategy
- [ ] Migration up/down testing
- [ ] Foreign key constraint validation
- [ ] Unique constraint testing (email, short_code)
- [ ] Data validation attribute testing
- [ ] Connection string environment testing

## ✅ Definition of Done
- [ ] All database tables created and working
- [ ] EF Core models implemented with proper relationships
- [ ] Migrations can be applied and rolled back
- [ ] Seed data loaded successfully
- [ ] Database queries working through EF Core
- [ ] Performance indexes created
- [ ] Connection string configurable via environment

## 📁 Affected Files
- `services/webapi/Models/`
  - `User.cs`
  - `Url.cs`
  - `ClickEvent.cs`
- `services/webapi/Data/`
  - `ShrtnrDbContext.cs`
  - `DbInitializer.cs`
- `services/webapi/Migrations/`
- `infrastructure/init-scripts/01-init-database.sql`
- `services/webapi/appsettings.json`

## 🚀 Success Metrics
- **Migration Time**: < 30 seconds for initial setup
- **Query Performance**: < 10ms for short_code lookup
- **Data Integrity**: All foreign keys and constraints working
- **Seed Data**: 100+ test URLs and users loaded