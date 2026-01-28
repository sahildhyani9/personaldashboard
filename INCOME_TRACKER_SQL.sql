-- Income Tracker Table Setup for Supabase
-- Run this SQL in Supabase SQL Editor to create the income table

-- Create income table
CREATE TABLE IF NOT EXISTS income (
    id BIGINT PRIMARY KEY,
    person TEXT NOT NULL,
    source TEXT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_income_person_year ON income(person, year);
CREATE INDEX IF NOT EXISTS idx_income_person_month ON income(person, year, month);
CREATE INDEX IF NOT EXISTS idx_income_date ON income(date);
CREATE INDEX IF NOT EXISTS idx_income_source ON income(source);

-- Enable RLS (Row Level Security) - optional but recommended
ALTER TABLE income ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all authenticated users to read/write their own data
CREATE POLICY "Allow public access" ON income
    FOR ALL USING (true) WITH CHECK (true);
