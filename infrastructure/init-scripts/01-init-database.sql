-- shrtnr Database Initialization Script

-- Create database schema for URL shortener
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- URLs table - Main entity for shortened URLs
CREATE TABLE urls (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    short_code VARCHAR(10) UNIQUE NOT NULL,
    original_url TEXT NOT NULL,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    title VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);

-- Click events table - For analytics
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

-- Create indexes for performance
CREATE INDEX idx_urls_short_code ON urls(short_code);
CREATE INDEX idx_urls_user_id ON urls(user_id);
CREATE INDEX idx_urls_created_at ON urls(created_at);
CREATE INDEX idx_click_events_url_id ON click_events(url_id);
CREATE INDEX idx_click_events_clicked_at ON click_events(clicked_at);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for automatic updated_at updates
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_urls_updated_at
    BEFORE UPDATE ON urls
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Sample data (optional for development)
INSERT INTO users (email, password_hash) VALUES 
    ('demo@example.com', '$2b$10$example_hash_here');

INSERT INTO urls (short_code, original_url, title) VALUES 
    ('demo123', 'https://www.example.com', 'Example Website'),
    ('test456', 'https://www.google.com', 'Google Search');

-- Views for analytics
CREATE VIEW url_stats AS
SELECT 
    u.id,
    u.short_code,
    u.original_url,
    u.title,
    u.created_at,
    COUNT(ce.id) as total_clicks,
    MAX(ce.clicked_at) as last_clicked,
    COUNT(DISTINCT ce.ip_address) as unique_visitors
FROM urls u
LEFT JOIN click_events ce ON u.id = ce.url_id
WHERE u.is_active = true
GROUP BY u.id, u.short_code, u.original_url, u.title, u.created_at;