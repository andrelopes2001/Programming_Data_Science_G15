import pandas as pd

# read CSV file into DataFrame
df = pd.read_csv('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\table6.csv')

# check for duplicates
#duplicates = df[df.duplicated()]

#if duplicates.empty:
#    print('No duplicates found')
#else:
#    print('Duplicate entries:')
#    print(duplicates)
