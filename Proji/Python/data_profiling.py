import pandas as pd
import matplotlib as plt

#Storing the data
data = pd.read_csv ('small_ca_monthly_data.csv') #reads the file
df=pd.DataFrame(data) #stores the data in a dataframe

#Discretize targer parameter
aux = pd.get_dummies(df,columns=['target'])
df['target'] = aux['target_True']
df = df.dropna(axis=1, how='all')


#Random Txt files
'''
#Check the dimensions of the dataset
print("Number of rows:", df.shape[0])
print("Number of columns:", df.shape[1])

#Check the data types of the columns
df.dtypes.to_csv('dtypes.csv')

#Check for missing values
df.isnull().sum().to_csv('null_sum.csv')

#Check the descriptive statistics of the numerical columns
df.describe().to_csv('description.csv')
'''
#Normal Histogram
'''
#Check the distribution of each numerical column using histograms
import matplotlib.pyplot as plt
f1 = plt.figure()
df.hist(figsize=(60, 60))
plt.savefig('hist.png')
'''

#Correlation
'''
#Check the correlation between numerical columns
import seaborn as sns
f2 = plt.figure()
corr = df.corr()
plt.figure(figsize = (60,60))
sns.heatmap(corr, annot=True)
plt.savefig('correlation.png')

#Check the distribution of the target variable (if applicable)
f3 = plt.figure()
sns.countplot(x="target", data=df)
plt.savefig('target_dist.png')
'''
#Sparsity

from pandas import read_csv
from pandas.plotting import register_matplotlib_converters
from matplotlib.pyplot import subplots, savefig, show
from ds_charts import get_variable_types, HEIGHT
'''
register_matplotlib_converters()
filename = 'small_ca_monthly_data.csv'
data = read_csv(filename)

numeric_vars = get_variable_types(data)['Numeric']
if [] == numeric_vars:
    raise ValueError('There are no numeric variables.')

rows, cols = len(numeric_vars)-1, len(numeric_vars)-1
fig, axs = subplots(rows, cols, figsize=(70, 70), squeeze=False)
for i in range(len(numeric_vars)):
    var1 = numeric_vars[i]
    for j in range(i+1, len(numeric_vars)):
        var2 = numeric_vars[j]
        axs[i, j-1].set_title("%s x %s"%(var1,var2))
        axs[i, j-1].set_xlabel(var1)
        axs[i, j-1].set_ylabel(var2)
        axs[i, j-1].scatter(data[var1], data[var2])
savefig('sparsity_study_numeric.png')
show()
'''

#Histograma Distribuicao
'''
from numpy import log
from pandas import Series
from scipy.stats import norm, expon, lognorm
from matplotlib.pyplot import savefig, show, subplots, Axes
from ds_charts import HEIGHT, multiple_line_chart, get_variable_types
print(1)
def compute_known_distributions(x_values: list) -> dict:
    distributions = dict()
    # Gaussian
    mean, sigma = norm.fit(x_values)
    distributions['Normal(%.1f,%.2f)'%(mean,sigma)] = norm.pdf(x_values, mean, sigma)
    # Exponential
    loc, scale = expon.fit(x_values)
    distributions['Exp(%.2f)'%(1/scale)] = expon.pdf(x_values, loc, scale)
    # LogNorm
    sigma, loc, scale = lognorm.fit(x_values)
    distributions['LogNor(%.1f,%.2f)'%(log(scale),sigma)] = lognorm.pdf(x_values, sigma, loc, scale)
    return distributions

def histogram_with_distributions(ax: Axes, series: Series, var: str):
    values = series.sort_values().values
    ax.hist(values, 20, density=True)
    distributions = compute_known_distributions(values)
    multiple_line_chart(values, distributions, ax=ax, title='Best fit for %s'%var, xlabel=var, ylabel='')

numeric_vars = get_variable_types(df)['Numeric']
if [] == numeric_vars:
    raise ValueError('There are no numeric variables.')
rows, cols = len(numeric_vars)-1, len(numeric_vars)-1
fig, axs = subplots(8, 6, figsize=(30, 30), squeeze=False)
i, j = 0, 0
print(2)
for n in range(len(numeric_vars)):
    histogram_with_distributions(axs[i, j], df[numeric_vars[n]].dropna(), numeric_vars[n])
    i, j = (i + 1, 0) if (n+1) % 6 == 0 else (i, j + 1)
print(3)
savefig('histogram_numeric_distribution4.png')
show()
'''

# Single Boxplots
'''
numeric_vars = get_variable_types(df)['Numeric']
if [] == numeric_vars:
    raise ValueError('There are no numeric variables.')

rows, cols = choose_grid(len(numeric_vars))

fig, axs = plt.subplots(8, 6, figsize=(20, 40))

i, j = 0, 0

for n in range(len(numeric_vars)):
    axs[i, j].set_title('Boxplot for %s'%numeric_vars[n])
    axs[i, j].boxplot(df[numeric_vars[n]].dropna().values)
    i, j = (i + 1, 0) if (n+1) % 6 == 0 else (i, j + 1)

plt.savefig('Programming_Data_Science_G15\Proji\Python/single_boxplots.png')
plt.show()
'''

# Global Boxplots
'''
fig, axs = plt.subplots(1, 1, figsize=(24, 8))
df.boxplot()
plt.savefig('Programming_Data_Science_G15\Proji\Python/global_boxplots.png')
plt.show()
'''