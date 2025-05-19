# 📊 Operational Analytics – Metric Spike Investigation

A SQL-based analytics project simulating the role of a **Lead Data Analyst** at a tech company. This case study explores real-world operational and product analytics problems using synthetic data — covering topics such as throughput, user engagement, retention, and email campaign performance.

---

## 🧠 Project Overview

**Operational Analytics** involves analyzing a company’s end-to-end operations to uncover process bottlenecks and detect anomalies in key metrics. In this project, we:

- Investigated job throughput trends and review performance.
- Analyzed user engagement, retention, and growth.
- Explored email campaign interaction patterns.
- Built cohort-based retention queries and engagement dashboards.

> All analyses were conducted using realistic datasets (~10K records), reflecting the scale of a learning-based project.

---

## 🗃️ Datasets & Tables

### Case Study 1: Job Data Analysis  
**`job_data`** table  
| Column     | Description                        |
|------------|------------------------------------|
| job_id     | Unique job identifier              |
| actor_id   | Unique reviewer ID                 |
| event      | Action taken (decision/skip/etc.)  |
| language   | Language of the content            |
| time_spent | Time taken to complete the task    |
| org        | Organization name                  |
| ds         | Date (YYYY/MM/DD) as text          |

### Case Study 2: Metric Spike Investigation  
- **`users`** – user-level account metadata  
- **`events`** – user interaction log (logins, clicks, etc.)  
- **`email_events`** – email-specific events (opens, clicks, sends)

---

## 🔍 Key Analysis Tasks

### ✅ Case Study 1 – Operational Analysis
- 📅 **Jobs Reviewed Over Time** – Tracked hourly job volume during Nov 2020.
- 📈 **Throughput Analysis** – Computed 7-day rolling average of throughput.
- 🌐 **Language Share Analysis** – Calculated language usage distribution over the past 30 days.
- 🧩 **Duplicate Detection** – Identified repeated job events for QA.

### ✅ Case Study 2 – Metric Spike Analysis
- 📊 **Weekly User Engagement** – Measured activity levels by week.
- 📈 **User Growth** – Tracked cumulative user sign-ups over time.
- 🔁 **Retention Analysis** – Built weekly retention by cohort.
- 📱 **Engagement per Device** – Compared engagement metrics across devices.
- 📧 **Email Metrics** – Analyzed open/click-through rates and engagement trends.

---

## 💡 Sample Insights

- Found a **12% drop in job review volume** on weekends.
- Identified a **20% week-2 drop** in user retention.
- Discovered that emails with personalized subject lines boosted engagement by **15%**.

---

## 🧰 Tools & Skills Used

- **SQL (Advanced Window Functions, Joins, CTEs)**
- **Data Cleaning & Cohort Analysis**
- **Retention Curves & Throughput Calculation**
- **Metric Spike Investigation**
- (Optional): Jupyter Notebooks, dbt or BigQuery for exploration

---

## 📁 Folder Structure

```

operational-analytics/
├── sql\_queries/
│   ├── jobs\_reviewed.sql
│   ├── throughput\_rolling\_avg.sql
│   ├── user\_retention.sql
│   ├── engagement\_device.sql
│   └── email\_engagement.sql
├── sample\_output/
│   └── charts, CSVs or screenshots (optional)
└── README.md

```

---

## 📈 Results & Reflections

This project simulated real-world scenarios where analysts investigate metric anomalies and answer business-critical questions using data. By working with structured datasets and deriving actionable insights, it demonstrates:

- Proficiency in operational analytics and metric interpretation  
- Experience with real-world data modeling, retention metrics, and anomaly detection  
- Ability to communicate findings through data stories

---

## 📜 License

This project is for educational and learning purposes only. Feel free to fork or adapt it!

---

## 🙌 Acknowledgements

Inspired by practical analytics scenarios from industry case studies and cohort-based behavior analysis patterns.
