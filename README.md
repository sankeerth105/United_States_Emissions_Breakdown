# United_States_Emissions_Breakdown

## 📌 Project Overview

This project analyzes **U.S. greenhouse gas (GHG) emissions data** using **Databricks SQL**. The analysis focuses on understanding emissions patterns at the **state and county levels**, calculating **emissions per person**, and preparing geographic emissions data for visualization.

The project uses Databricks for data analysis and dashboard development, with SQL queries used to transform, aggregate, and analyze the emissions data.

---

## 🎯 Objectives

* Analyze greenhouse gas emissions across U.S. states and counties.
* Identify states with the highest total emissions.
* Identify counties with the highest total emissions.
* Calculate emissions per person at the county level.
* Prepare latitude and longitude data for geographic visualization.
* Present the analysis through an interactive Databricks dashboard.

---

## 🛠️ Tools & Technologies

* **Databricks Free Edition**
* **Databricks SQL**
* **SQL**
* **Data Visualization**
* **Databricks Dashboard**
* **CSV Dataset**

---

## 📊 Dataset

The dataset contains U.S. county-level information related to greenhouse gas emissions and geographic and demographic attributes.

### Key Columns

| Column                     | Description                                                        |
| -------------------------- | ------------------------------------------------------------------ |
| `state_abbr`               | U.S. state abbreviation                                            |
| `county_state_name`        | County and state name                                              |
| `county_id`                | County identifier                                                  |
| `county_name`              | County name                                                        |
| `latitude`                 | Geographic latitude                                                |
| `longitude`                | Geographic longitude                                               |
| `population`               | County population                                                  |
| `GHG emissions mtons CO2e` | Greenhouse gas emissions measured in metric tons of CO₂ equivalent |

---

## 🔄 Project Workflow

```text
Raw CSV Dataset
       ↓
Databricks
       ↓
Data Exploration
       ↓
Data Cleaning & Type Conversion
       ↓
SQL Analysis
       ↓
KPI & Aggregation Queries
       ↓
Databricks Dashboard
       ↓
Insights & Visualization
```

---

## 🔎 SQL Analysis

### 1. Geographic Emissions Data

Latitude and longitude were extracted along with greenhouse gas emissions to support geographic visualization.

```sql
SELECT
    latitude,
    longitude,
    `GHG emissions mtons CO2e` AS emissions
FROM emissions_data;
```

### 2. Top 10 Counties by Emissions per Person

Calculated emissions per person by dividing total emissions by county population.

The query also handles comma-separated numeric values and prevents division by zero.

```sql
SELECT
    county_state_name,
    population,
    TRY_CAST(
        regexp_replace(`GHG emissions mtons CO2e`, ',', '')
        AS DOUBLE
    ) / NULLIF(population, 0) AS emissions_per_person
FROM emissions_data
ORDER BY emissions_per_person DESC
LIMIT 10;
```

### 3. Top 10 States by Total Emissions

Aggregated emissions at the state level using `SUM()` and `GROUP BY`.

```sql
SELECT
    state_abbr,
    SUM(
        TRY_CAST(
            regexp_replace(`GHG emissions mtons CO2e`, ',', '')
            AS DOUBLE
        )
    ) AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC
LIMIT 10;
```

### 4. Top 10 Counties by Total Emissions

Identified counties with the highest total greenhouse gas emissions.

```sql
SELECT
    county_state_name,
    population,
    TRY_CAST(
        regexp_replace(`GHG emissions mtons CO2e`, ',', '')
        AS DOUBLE
    ) AS total_emissions
FROM emissions_data
ORDER BY total_emissions DESC
LIMIT 10;
```

---

## 📈 Dashboard

The SQL analysis was used to create an interactive dashboard in Databricks.

The dashboard presents emissions information through visualizations such as:

* State-level emissions comparison
* County-level emissions analysis
* Emissions per person
* Geographic emissions visualization
* Key emissions metrics



---

## 💡 Key Analysis Areas

The project focuses on four main analytical questions:

1. **Which U.S. states have the highest total greenhouse gas emissions?**
2. **Which counties have the highest total greenhouse gas emissions?**
3. **Which counties have the highest emissions per person?**
4. **How can geographic coordinates be used to visualize emissions patterns?**

---

## 📁 Repository Structure

```text
US-Emissions-Databricks-Analysis/
│
├── README.md
│
├── sql/
│   └── emissions_analysis.sql
│
├── dashboard/
│   └── emissions_dashboard.png
│
└── data/
    └── README.md
```

---

## 🧠 SQL Concepts Used

* `SELECT`
* `WHERE` / filtering
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* `SUM()`
* Calculated columns
* `TRY_CAST()`
* `regexp_replace()`
* `NULLIF()`
* Aggregation
* Ranking and top-N analysis

---

## 🚀 Skills Demonstrated

This project demonstrates practical experience with:

* SQL-based data analysis
* Data cleaning and type conversion
* Aggregation and KPI calculations
* Geographic data analysis
* Population-based normalization
* Databricks SQL
* Dashboard development
* Data visualization
* Extracting insights from structured datasets

---

## 📌 Conclusion

This project demonstrates how **Databricks SQL** can be used to transform and analyze U.S. greenhouse gas emissions data and present the results through an interactive dashboard.

The analysis combines **state-level, county-level, per-person, and geographic perspectives** to provide a structured view of emissions patterns across the United States.
