# --------------------------------------------
# Query 01: Monthly & Cumulative Internet Sales by Country
# --------------------------------------------

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import matplotlib.dates as mdates

monthly_sales = pd.read_csv("monthly_sales_by_country.csv")

monthly_sales["YearMonth"] = pd.to_datetime(
    monthly_sales["CalendarYear"].astype(str) + "-" +
    monthly_sales["Month"].astype(str) + "-01"
)

monthly_sales = monthly_sales.sort_values(
    ["Country", "YearMonth"]
)

monthly_sales["CumulativeSales"] = (
    monthly_sales
    .groupby("Country")["TotalSales"]
    .cumsum()
)

plt.figure(figsize=(12, 6))

sns.lineplot(
    data=monthly_sales,
    x="YearMonth",
    y="TotalSales",
    hue="Country",
    marker="o"
)

plt.title("Monthly Internet Sales by Country")
plt.xlabel("Year-Month")
plt.ylabel("Monthly Sales")

ax = plt.gca()
ax.xaxis.set_major_formatter(mdates.DateFormatter("%b %Y"))
ax.xaxis.set_major_locator(mdates.MonthLocator(interval=3))

plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("MonthlySales.png")
plt.show()

plt.figure(figsize=(12, 6))

sns.lineplot(
    data=monthly_sales,
    x="YearMonth",
    y="CumulativeSales",
    hue="Country",
    marker="o"
)

plt.title("Cumulative Internet Sales by Country")
plt.xlabel("Year-Month")
plt.ylabel("Cumulative Sales")

ax = plt.gca()
ax.xaxis.set_major_formatter(mdates.DateFormatter("%b %Y"))
ax.xaxis.set_major_locator(mdates.MonthLocator(interval=3))

plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("CumulativeSales.png")
plt.show()

# --------------------------------------------
# Query 2: Customer Sales Concentration (Pareto Analysis)
# --------------------------------------------

import pandas as pd
import matplotlib.pyplot as plt

# Load data
customer_sales = pd.read_csv("Customers_Sales.csv")

# Sort descending
customer_sales = customer_sales.sort_values(
    by="TotalSales",
    ascending=False
).reset_index(drop=True)

# Calculate cumulative contribution
customer_sales["CumulativeSales"] = customer_sales["TotalSales"].cumsum()
customer_sales["CumulativePercentage"] = (
    customer_sales["CumulativeSales"] / customer_sales["TotalSales"].sum()
) * 100

# Plot Pareto chart
plt.figure(figsize=(10,6))

plt.plot(
    customer_sales.index + 1,
    customer_sales["CumulativePercentage"],
    marker="o"
)

plt.axhline(80, color="red", linestyle="--", label="80% Revenue Threshold")

plt.title("Customer Revenue Concentration (Pareto Analysis)")
plt.xlabel("Number of Customers")
plt.ylabel("Cumulative % of Total Sales")
plt.legend()
plt.tight_layout()

plt.savefig("customer_sales_pareto.png", dpi=300)
plt.show()
