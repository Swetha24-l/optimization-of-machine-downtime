'''Optimization of machine downtime
Business problem: Machines which manufacture the pumps. Unplanned machine downtime which is leading to loss of productivity.
Business objective: Minimize unplanned machine downtime.
Business constraint: Minimize maintance cost.

Business success criteria: Reduce the unplanned downtime by at least 10%
Economic success criteria: Achieve a cost saving of at least $1M'''

import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.impute import SimpleImputer
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv(r"C:\Users\sweth\Desktop\Data analyst project\Machine Downtime.csv")

#Display sample 10 rows from data
df.sample(10)

#Show the first five row in the data
df.head()   

# Checking the shape of the data
df.shape

#Desctibe the data
df.describe()

#Find the information of the data
df.info()

#Find the duplicate value 
df.duplicated().sum()

#Checking missing value in the data
df.isnull().sum()


# Select only numeric columns
numeric_cols = df.select_dtypes(include=['float64', 'int64']).columns
categorical_cols = df.select_dtypes(include=['object', 'category']).columns


# First Moment Business Decision
mean_value = df[numeric_cols].mean()
print(mean_value)

median_value = df[numeric_cols].median()
print(median_value)

mode_value = df[numeric_cols].mode()
print(mode_value)


# Second Moment Business Decision
variance_values = df[numeric_cols].var()
print(variance_values)
stds_values = df[numeric_cols].std()
print(stds_values)
range_values = df.max(numeric_only=True) - df.min(numeric_only=True)
print(range_values)



# Third Moment: Skewness
skewness = df[numeric_cols].skew()
print(skewness)

# Fourth Moment: Kurtosis
kurtosis = df[numeric_cols].kurt()
print(kurtosis)

#Graphical Representation
#Univarient

# Select numeric columns only
numeric_cols = df.select_dtypes(include=['float64']).columns

# Set style
sns.set(style="whitegrid")

# Plot histograms, boxplots, and KDEs for each numeric feature
for col in numeric_cols:
    plt.figure(figsize=(16, 4))

    # Histogram
    plt.subplot(1, 3, 1)
    sns.histplot(df[col], kde=False, bins=30, color='skyblue')
    plt.title(f'Histogram of {col}')
    
    # Boxplot
    plt.subplot(1, 3, 2)
    sns.boxplot(x=df[col], color='orange')
    plt.title(f'Boxplot of {col}')

    # KDE (Density Plot)
    plt.subplot(1, 3, 3)
    sns.kdeplot(df[col], fill=True, color='green')
    plt.title(f'Density Plot of {col}')

    plt.tight_layout()
    plt.show()

# Select categorical columns
categorical_cols = df.select_dtypes(include=['object']).columns

# Plot count plots for each categorical column
for col in categorical_cols:
    plt.figure(figsize=(10, 4))
    sns.countplot(data=df, x=col, palette='Set2', order=df[col].value_counts().index)
    plt.title(f'Distribution of {col}')
    plt.xticks(rotation=45)
    plt.xlabel(col)
    plt.ylabel('Count')
    plt.tight_layout()
    plt.show()




#Bivarient
# Convert 'Downtime' to category if not already
df['Downtime'] = df['Downtime'].astype('category')

#Correlation Heatmap (Numeric vs Numeric)
plt.figure(figsize=(12, 10))
sns.heatmap(df[numeric_cols].corr(), annot=True, cmap='coolwarm')
plt.title("Correlation Heatmap Between Numeric Variables")
plt.show()
#Scatter Plots (Pairwise numeric features)
sns.pairplot(df, vars=numeric_cols[:4], hue='Downtime')
plt.suptitle("Pairplot of Selected Numeric Features", y=1.02)
plt.show()
#Boxplots (Numeric vs Categorical)
for col in numeric_cols[:6]:  # Limit to first few features for demonstration
    plt.figure(figsize=(6, 4))
    sns.boxplot(x='Downtime', y=col, data=df)
    plt.title(f"{col} vs Downtime")
    plt.show()
#Categorical vs Categorical (Downtime vs Assembly Line)
plt.figure(figsize=(6, 4))
sns.countplot(x='Assembly_Line_No', hue='Downtime', data=df)
plt.title("Downtime Count Across Assembly Lines")
plt.show()

# Select categorical columns
categorical_cols = df.select_dtypes(include=['object']).columns

# Plot count plots for each categorical column
for col in categorical_cols:
    plt.figure(figsize=(10, 4))
    sns.countplot(data=df, x=col, palette='Set2', order=df[col].value_counts().index)
    plt.title(f'Distribution of {col}')
    plt.xticks(rotation=45)
    plt.xlabel(col)
    plt.ylabel('Count')
    plt.tight_layout()
    plt.show()
    
#Multivarient 
#Correlation Heatmap
plt.figure(figsize=(12, 10))
sns.heatmap(df[numeric_cols].corr(), annot=True, fmt=".2f", cmap="coolwarm")
plt.title("Multivariate Correlation Heatmap")
plt.show()

# Select only object (categorical) columns
categorical_cols = df.select_dtypes(include=['object']).columns.tolist()

# Set target column
target_col = 'Downtime'

# Remove target from features
features = [col for col in categorical_cols if col != target_col]

# Crosstab and heatmap for each pair with target
for col in features:
    cross_tab = pd.crosstab(df[col], df[target_col], normalize='index')  # percentage-wise
    plt.figure(figsize=(8, 4))
    sns.heatmap(cross_tab, annot=True, cmap='YlGnBu', fmt='.2f')
    plt.title(f'{col} vs {target_col} (Proportional Heatmap)')
    plt.ylabel(col)
    plt.xlabel(target_col)
    plt.tight_layout()
    plt.show()

    
#Data Preparation
#Convert Date and Extract Features
df['Date'] = pd.to_datetime(df['Date'], dayfirst=True, errors='coerce')
df['Year'] = df['Date'].dt.year
df['Month'] = df['Date'].dt.month
df['Day'] = df['Date'].dt.day
df.drop(columns=['Date'], inplace=True)

#Handle Missing Values
#Separate numeric and categorical columns
numeric_cols = df.select_dtypes(include=['float64', 'int64']).columns
categorical_cols = df.select_dtypes(include=['object', 'category']).columns

# Impute numeric features with mean
imputer = SimpleImputer(strategy='mean')
df[numeric_cols] = imputer.fit_transform(df[numeric_cols])

# Impute categorical features with most frequent
cat_imputer = SimpleImputer(strategy='most_frequent')
df[categorical_cols] = cat_imputer.fit_transform(df[categorical_cols])

#Encode Categorical Variables
label_encoders = {}
for col in categorical_cols:
    le = LabelEncoder()
    df[col] = le.fit_transform(df[col])
    label_encoders[col] = le # Store encoders for inverse_transform if needed

#Outlier Treatment (IQR Capping)
for col in numeric_cols:
    Q1 = df[col].quantile(0.25)
    Q3 = df[col].quantile(0.75)
    IQR = Q3 - Q1
    lower = Q1 - 1.5 * IQR
    upper = Q3 + 1.5 * IQR
    df[col] = np.clip(df[col], lower, upper)
    
#Feature Scaling
scaler = StandardScaler()
df[numeric_cols] = scaler.fit_transform(df[numeric_cols])

#Final Check 
print("✅ Data preparation complete.")
print(df.head())
print("Shape:", df.shape)





