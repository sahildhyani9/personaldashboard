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
    payee TEXT NOT NULL,
    category TEXT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    description TEXT DEFAULT '',
    year INTEGER,
    month INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2b. If you already have an expenses table without payee column, run this:
-- ALTER TABLE expenses ADD COLUMN IF NOT EXISTS payee TEXT NOT NULL DEFAULT '';

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

-- 5. Create settlements table
CREATE TABLE IF NOT EXISTS settlements (
    id TEXT PRIMARY KEY,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    person_from TEXT NOT NULL,
    person_to TEXT NOT NULL,
    sd_owes_pg DECIMAL(10, 2) DEFAULT 0,
    pg_owes_sd DECIMAL(10, 2) DEFAULT 0,
    net_amount DECIMAL(10, 2) NOT NULL,
    net_owed_by TEXT NOT NULL,
    is_paid BOOLEAN DEFAULT FALSE,
    paid_on TIMESTAMP,
    notes TEXT DEFAULT '',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(year, month)
);

-- 6. Enable RLS (Row Level Security) - Optional for security
-- Disable RLS if you want to allow public access (simpler for now)
ALTER TABLE categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE expenses DISABLE ROW LEVEL SECURITY;
ALTER TABLE investments DISABLE ROW LEVEL SECURITY;
ALTER TABLE schemes DISABLE ROW LEVEL SECURITY;
ALTER TABLE settlements DISABLE ROW LEVEL SECURITY;

-- 7. Create indexes for faster queries (optional but recommended)
CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses(date);
CREATE INDEX IF NOT EXISTS idx_expenses_person ON expenses(person);
CREATE INDEX IF NOT EXISTS idx_expenses_category ON expenses(category);
CREATE INDEX IF NOT EXISTS idx_expenses_payee ON expenses(payee);
CREATE INDEX IF NOT EXISTS idx_investments_date ON investments(date);
CREATE INDEX IF NOT EXISTS idx_investments_person ON investments(person);
CREATE INDEX IF NOT EXISTS idx_settlements_year_month ON settlements(year, month);
CREATE INDEX IF NOT EXISTS idx_settlements_paid ON settlements(is_paid);

-- Run all queries above in Supabase SQL Editor
-- After running, you can start adding data through the dashboard!
-- 
-- NOTE: If you already have data in expenses table, run this to add the payee column:
-- ALTER TABLE expenses ADD COLUMN IF NOT EXISTS payee TEXT NOT NULL DEFAULT '';
