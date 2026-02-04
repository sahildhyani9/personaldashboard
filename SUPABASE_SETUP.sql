-- ============================================================
-- SUPABASE SETUP SQL FOR CATEGORY GROUPS AND MAPPINGS
-- ============================================================
-- Run this SQL in Supabase Dashboard → SQL Editor
-- Copy and paste all the queries below

-- Create category_groups table
CREATE TABLE IF NOT EXISTS category_groups (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Create category_mappings table
CREATE TABLE IF NOT EXISTS category_mappings (
    id TEXT PRIMARY KEY,
    category_name TEXT NOT NULL,
    group_name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(category_name)
);

-- Create category_group_budgets table
CREATE TABLE IF NOT EXISTS category_group_budgets (
    id TEXT PRIMARY KEY,
    group_name TEXT NOT NULL,
    year INTEGER NOT NULL,
    budget_amount DECIMAL(12,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(group_name, year)
);

-- Create categories table (if not already exists)
CREATE TABLE IF NOT EXISTS categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create expenses table (if not already exists)
CREATE TABLE IF NOT EXISTS expenses (
    id BIGINT PRIMARY KEY,
    person TEXT NOT NULL,
    payee TEXT,
    category TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    year INTEGER,
    month INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create investments table (if not already exists)
CREATE TABLE IF NOT EXISTS investments (
    id BIGINT PRIMARY KEY,
    person TEXT NOT NULL,
    scheme TEXT NOT NULL,
    type TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    current_value DECIMAL(10,2),
    date DATE NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create schemes table (if not already exists)
CREATE TABLE IF NOT EXISTS schemes (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create income table (if not already exists)
CREATE TABLE IF NOT EXISTS income (
    id BIGINT PRIMARY KEY,
    person TEXT NOT NULL,
    source TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    year INTEGER,
    month INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create settlements table (if not already exists)
CREATE TABLE IF NOT EXISTS settlements (
    id TEXT PRIMARY KEY,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    is_paid BOOLEAN DEFAULT FALSE,
    paid_on DATE,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(year, month)
);

-- Enable Row Level Security (optional but recommended)
ALTER TABLE category_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE category_mappings ENABLE ROW LEVEL SECURITY;
ALTER TABLE category_group_budgets ENABLE ROW LEVEL SECURITY;

-- Create policies to allow all operations (for development - adjust for production)
CREATE POLICY "Allow all operations on category_groups" 
ON category_groups FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations on category_mappings" 
ON category_mappings FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations on category_group_budgets" 
ON category_group_budgets FOR ALL USING (true) WITH CHECK (true);

-- ============================================================
-- INSTRUCTIONS:
-- 1. Go to https://app.supabase.com
-- 2. Select your project
-- 3. Go to SQL Editor
-- 4. Create a new query
-- 5. Copy and paste all the SQL above
-- 6. Click "Run" button
-- 7. Refresh your dashboard
-- ============================================================
