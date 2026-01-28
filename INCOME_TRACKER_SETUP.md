# Income Tracker - Setup & Usage Guide

## Overview
The Income Tracker module allows users to record income from various sources and automatically compare it against expenses to determine budget status (within budget or overspend).

## Features Implemented

### 1. **Income Data Management**
- Add income entries with:
  - Person (who earned the income)
  - Source (Salary, Freelance, Bonus, Gift, Refund, Investment Returns, Other)
  - Amount (in rupees)
  - Date (when income was received)
  - Description (optional notes)

- Edit existing income entries
- Delete income entries
- Filter by person and year

### 2. **Income vs Expense Analysis**
Real-time comparison showing:
- **Total Income**: Sum of all income entries
- **Total Expenses**: Sum of all expenses
- **Balance**: Difference between income and expenses
- **Budget Status**: 
  - ✓ Within Budget (if Income ≥ Expenses)
  - ✗ Over Budget (if Expenses > Income)
- **Budget Utilization**: Percentage of income spent

### 3. **Supabase Integration**
- Automatic sync of income data to Supabase
- Read/write capabilities
- Table: `income` with columns:
  - id, person, source, amount, date, description, year, month, created_at

### 4. **Filtering & Statistics**
- Filter by person
- Filter by year
- Real-time stats update on filter changes
- Dynamic color indicators (green for surplus, red for deficit)

## Database Schema

```sql
CREATE TABLE income (
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

CREATE INDEX idx_income_person_year ON income(person, year);
CREATE INDEX idx_income_date ON income(date);
```

## HTML Elements Required

Add these to your HTML document:

### Income Form Section
```html
<div id="incomeSection">
    <!-- Income Input Form -->
    <div class="form-group">
        <label>Person</label>
        <select id="incomePerson">
            <option value="S.D">S.D</option>
            <option value="P.G">P.G</option>
        </select>
    </div>
    
    <div class="form-group">
        <label>Income Source</label>
        <select id="incomeSource">
            <option value="">Select Source</option>
            <option value="Salary">Salary</option>
            <option value="Freelance">Freelance</option>
            <option value="Bonus">Bonus</option>
            <option value="Gift">Gift</option>
            <option value="Refund">Refund</option>
            <option value="Investment Returns">Investment Returns</option>
            <option value="Other">Other</option>
        </select>
    </div>
    
    <div class="form-group">
        <label>Amount (₹)</label>
        <input type="number" id="incomeAmount" placeholder="0.00" min="0" step="0.01">
    </div>
    
    <div class="form-group">
        <label>Date</label>
        <input type="date" id="incomeDate">
    </div>
    
    <div class="form-group">
        <label>Description (Optional)</label>
        <input type="text" id="incomeDescription" placeholder="e.g., Monthly salary, Freelance project">
    </div>
    
    <button onclick="addIncome()" class="primary-btn">Add Income</button>
</div>

<!-- Income Statistics -->
<div id="incomeStatsGrid" class="stats-grid"></div>

<!-- Income Filters -->
<div class="filter-group">
    <select id="incomePersonFilter" onchange="applyIncomeFilters()">
        <option value="">All People</option>
        <option value="S.D">S.D</option>
        <option value="P.G">P.G</option>
        <option value="compiled">Compiled</option>
    </select>
    
    <select id="incomeYearFilter" onchange="applyIncomeFilters()">
        <option value="">All Years</option>
    </select>
</div>

<!-- Income Table -->
<table>
    <thead>
        <tr>
            <th>Date</th>
            <th>Person</th>
            <th>Source</th>
            <th>Amount</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody id="incomeTableBody"></tbody>
</table>

<!-- Edit Income Modal -->
<div id="editIncomeModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditIncomeModal()">&times;</span>
        <h2>Edit Income Entry</h2>
        <form id="editIncomeForm">
            <div class="form-group">
                <label>Amount (₹)</label>
                <input type="number" id="editIncomeAmount" min="0" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label>Source</label>
                <input type="text" id="editIncomeSource" required>
            </div>
            
            <div class="form-group">
                <label>Date</label>
                <input type="date" id="editIncomeDate" required>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <input type="text" id="editIncomeDescription">
            </div>
            
            <button type="button" onclick="saveEditedIncome()" class="primary-btn">Save Changes</button>
        </form>
    </div>
</div>
```

## JavaScript Functions Available

### Core Functions
- `addIncome()` - Add new income entry
- `deleteIncome(id)` - Delete income entry
- `renderIncomeTable()` - Render income table with filters
- `updateIncomeStats()` - Update statistics cards
- `openEditIncomeModal(id)` - Open edit modal
- `closeEditIncomeModal()` - Close edit modal
- `saveEditedIncome()` - Save edited income
- `applyIncomeFilters()` - Apply person/year filters

### Supabase Functions
- `syncIncomeToSupabase(incomeData)` - Sync to Supabase
- `deleteIncomeFromSupabase(id)` - Delete from Supabase

## How It Works

### Data Flow
1. User enters income data in the form
2. Income is added to `appData.income` array
3. Data is synced to Supabase (if enabled)
4. `renderIncomeTable()` displays the entry
5. `updateIncomeStats()` calculates and displays:
   - Total income
   - Total expenses (from existing expense tracker)
   - Balance (Income - Expenses)
   - Budget status indicator
   - Budget utilization percentage

### Budget Status Logic
```
If Total Income >= Total Expenses:
    Status = "✓ Within Budget" (Green)
    Balance = Income - Expenses (Positive)
Else:
    Status = "✗ Over Budget" (Red)
    Balance = Expenses - Income (Shown as absolute value)
```

### Budget Utilization
```
Utilization % = (Total Expenses / Total Income) × 100
```

## Integration Steps

1. **Add to Data Structure** ✓ (Already done)
   - Added `income: []` to appData
   - Added `incomeCategories` array

2. **Add HTML Elements** (User to do)
   - Copy HTML elements from above section

3. **Run SQL Setup** (User to do)
   - Execute the SQL schema in Supabase

4. **Initialize on App Load** (Add to initApp())
   ```javascript
   renderIncomeTable();
   updateIncomeStats();
   ```

5. **Add to Filters Update** (In populateYearFilters())
   ```javascript
   [document.getElementById('incomeYearFilter')].forEach(select => {
       // Update year filters
   });
   ```

## Usage Examples

### Example 1: Monthly Salary Entry
- Person: S.D
- Source: Salary
- Amount: ₹50,000
- Date: 2026-01-15
- Description: Monthly salary - January

### Example 2: Freelance Income
- Person: P.G
- Source: Freelance
- Amount: ₹15,000
- Date: 2026-01-20
- Description: Web design project payment

### Example 3: Budget Analysis
If S.D has:
- Income: ₹50,000
- Expenses: ₹45,000
- Balance: ₹5,000 ✓ Within Budget (10% utilization)

If expenses exceed ₹50,000:
- Balance: Shows overspend amount ✗ Over Budget

## Features Not Yet Implemented

The following can be added in future updates:
- Income trends/charts
- Recurring income setup
- Budget planning (set income targets)
- Expense category warnings
- Monthly recurring expense tracking
- Savings goal tracking
- PDF export of income statements

## Notes

- Income data persists in localStorage and Supabase
- All calculations are real-time and update on every change
- Filtering works across all metrics
- Color indicators help quickly identify budget status
- Edit functionality allows updating any field except ID
