-- Supabase Setup SQL - Run this in Supabase → SQL Editor
-- This will create all necessary tables for the dashboard

-- 1. Create categories table
CREATE TABLE IF NOT EXISTS categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. Create expenses table
CREATE TABLE IF NOT EXISTS expenses (
    id BIGINT PRIMARY KEY,
    person TEXT NOT NULL,
    category TEXT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    description TEXT DEFAULT '',
    year INTEGER,
    month INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 3. Create investments table
CREATE TABLE IF NOT EXISTS investments (
    id BIGINT PRIMARY KEY,
    person TEXT NOT NULL,
    scheme TEXT NOT NULL,
    type TEXT DEFAULT 'lumpsum',
    amount DECIMAL(10, 2) NOT NULL,
    current_value DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    notes TEXT DEFAULT '',
    created_at TIMESTAMP DEFAULT NOW()
);

-- 4. Create schemes table
CREATE TABLE IF NOT EXISTS schemes (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 5. Enable RLS (Row Level Security) - Optional for security
-- Disable RLS if you want to allow public access (simpler for now)
ALTER TABLE categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE expenses DISABLE ROW LEVEL SECURITY;
ALTER TABLE investments DISABLE ROW LEVEL SECURITY;
ALTER TABLE schemes DISABLE ROW LEVEL SECURITY;

-- 6. Create indexes for faster queries (optional but recommended)
CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses(date);
CREATE INDEX IF NOT EXISTS idx_expenses_person ON expenses(person);
CREATE INDEX IF NOT EXISTS idx_expenses_category ON expenses(category);
CREATE INDEX IF NOT EXISTS idx_investments_date ON investments(date);
CREATE INDEX IF NOT EXISTS idx_investments_person ON investments(person);

-- Run all queries above in Supabase SQL Editor
-- After running, you can start adding data through the dashboard!
