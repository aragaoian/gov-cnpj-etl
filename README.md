# CNPJ ETL

> [!NOTE]  
> The idea for this project was copied from this [post](https://www.linkedin.com/feed/update/urn:li:activity:7408660461782618112?updateEntityUrn=urn%3Ali%3Afs_updateV2%3A%28urn%3Ali%3Aactivity%3A7408660461782618112%2CFEED_DETAIL%2CEMPTY%2CDEFAULT%2Cfalse%29) that provides valuable resources for hands-on practice of data engineering concepts.

**The Brazilian Federal Revenue Service (Receita Federal)** provides free public data on **50+ million Brazilian companies (CNPJs)**. These are **tens of GBs of CSV files** that must be:

✓ Downloaded and processed monthly
✓ Normalized (CNAE codes, municipalities, legal nature)
✓ Related (companies + establishments + partners/shareholders)
✓ Transformed into value (aggregations, dataset joins, data cleaning, etc.)

[**Data link**](https://arquivos.receitafederal.gov.br/index.php/s/YggdBLfdninEJX9)

---

## **THE CHALLENGE (choose your level)**

### 🟢 **BEGINNER**

Build a script that downloads and loads the data into PostgreSQL/MySQL. Answer using SQL:

✓ How many active companies per state? <br>
✓ Top 10 most common CNAE codes <br>
✓ Distribution by company size (MEI, ME, EPP) <br>

**Suggested skills:** Python, SQL, Pandas

### 🟡 **INTERMEDIATE**

Create an automated ETL pipeline:

✓ Scheduled incremental downloads  <br>
✓ Data integrity and duplication validation <br>
✓ Dimensional modeling (star schema) <br>
✓ Basic dashboard in Metabase / Superset / Power BI / Tableau <br>

**Suggested skills:** Airflow, dbt, DVC, Docker, AWS S3, AWS RDS

### 🔴 **ADVANCED**

Build a complete data engineering architecture:

✓ Distributed ingestion (Spark / Dask / Trino) <br>
✓ Data lake built with Medallion architecture <br>
✓ Metadata catalog for documentation <br>
✓ REST API for queries (you could even charge for this!) <br>
✓ Monitoring and data quality <br>
✓ Full CI/CD (data deployed to production) <br>

**Suggested skills:** Spark, Kubernetes, Terraform, FastAPI, Great Expectations, AWS API Gateway
