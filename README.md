# CNPJ ETL

> [!NOTE]  
> This idea was inspired by a [https://www.linkedin.com/feed/update/urn:li:activity:7408660461782618112?updateEntityUrn=urn%3Ali%3Afs_updateV2%3A%28urn%3Ali%3Aactivity%3A7408660461782618112%2CFEED_DETAIL%2CEMPTY%2CDEFAULT%2Cfalse%29](LinkedIn post) that provides valuable resources for hands-on practice of data engineering concepts.

**The Brazilian Federal Revenue Service (Receita Federal)** provides free public data on **50+ million Brazilian companies (CNPJs)**. These are **tens of GBs of CSV files** that must be:

✓ Downloaded and processed monthly
✓ Normalized (CNAE codes, municipalities, legal nature)
✓ Related (companies + establishments + partners/shareholders)
✓ Transformed into value (aggregations, dataset joins, data cleaning, etc.)

**Data link:** [https://lnkd.in/eK3QGc9Q](https://lnkd.in/eK3QGc9Q)

---

## **THE CHALLENGE (choose your level)**

### 🟢 **BEGINNER**

Build a script that downloads and loads the data into PostgreSQL/MySQL. Answer using SQL:

✓ How many active companies per state?
✓ Top 10 most common CNAE codes
✓ Distribution by company size (MEI, ME, EPP)

**Suggested skills:** Python, SQL, Pandas

### 🟡 **INTERMEDIATE**

Create an automated ETL pipeline:

✓ Scheduled incremental downloads
✓ Data integrity and duplication validation
✓ Dimensional modeling (star schema)
✓ Basic dashboard in Metabase / Superset / Power BI / Tableau

**Suggested skills:** Airflow, dbt, DVC, Docker, AWS S3, AWS RDS

### 🔴 **ADVANCED**

Build a complete data engineering architecture:

✓ Distributed ingestion (Spark / Dask / Trino)
✓ Data lake built with Medallion architecture
✓ Metadata catalog for documentation
✓ REST API for queries (you could even charge for this!)
✓ Monitoring and data quality
✓ Full CI/CD (data deployed to production)

**Suggested skills:** Spark, Kubernetes, Terraform, FastAPI, Great Expectations, AWS API Gateway
