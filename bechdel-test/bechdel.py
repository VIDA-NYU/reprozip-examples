import numpy as np
import pandas as pd
from itertools import product
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import statsmodels.formula.api as smf

print("Loading data...")

## Revenue Data
numbers_df = pd.read_csv('revenue.csv',encoding='utf8',index_col=0)
numbers_df['Released'] = pd.to_datetime(numbers_df['Released'])

## Inflation Data
cpi = pd.read_csv('cpi.csv',index_col='Year')
inflator = dict(cpi.ix[2014,'Annual']/cpi['Annual'])

## Bechdel Data
ratings_df = pd.read_json('bechdel.json')
ratings_df['imdbid'] = ratings_df['imdbid'].dropna().apply(int)
ratings_df = ratings_df.set_index('imdbid')
ratings_df.dropna(subset=['title'],inplace=True)
ratings_df2 = ratings_df[['rating','title']]

## IMDB Data

# Read the data in
imdb_df = pd.read_json('imdb_data.json')


print("Cleaning IMDB data...")

# Drop non-movies
imdb_df = imdb_df[imdb_df['Type'] == 'movie']

# Convert to datetime objects
imdb_df['Released'] = pd.to_datetime(imdb_df['Released'], format="%d %b %Y", errors='coerce')

# Drop errant identifying characters in the ID field
imdb_df['imdbID'] = imdb_df['imdbID'].str.slice(start=2)

# Remove the " min" at the end of Runtime entries so we can convert to ints
imdb_df['Runtime'] = imdb_df['Runtime'].str.slice(stop=-4).replace('',np.nan)

# Some errant runtimes have "h" in them. Commented-out code below identifies them.
#s = imdb_df['Runtime'].dropna()
#s[s.str.contains('h')]

# Manually recode these h-containing Runtimes to minutes
print("%s: %s -> %s" % (imdb_df.ix[946, 'Title'], imdb_df.ix[946, 'Runtime'],
                        '169'))
imdb_df.ix[946,'Runtime'] = '169'
print("%s: %s -> %s" % (imdb_df.ix[1192, 'Title'], imdb_df.ix[1192, 'Runtime'],
                        '96'))
imdb_df.ix[1192,'Runtime'] = '96'
print("%s: %s -> %s" % (imdb_df.ix[1652, 'Title'], imdb_df.ix[1652, 'Runtime'],
                        '80'))
imdb_df.ix[1652,'Runtime'] = '80'
print("%s: %s -> %s" % (imdb_df.ix[2337, 'Title'], imdb_df.ix[2337, 'Runtime'],
                        '87'))
imdb_df.ix[2337,'Runtime'] = '87'
print("%s: %s -> %s" % (imdb_df.ix[3335, 'Title'], imdb_df.ix[3335, 'Runtime'],
                        '62'))
imdb_df.ix[3335,'Runtime'] = '62'

# Blank out non-MPAA or minor ratings (NC-17, X)
imdb_df['Rated'] = imdb_df['Rated'].replace(to_replace=['N/A','Not Rated','Approved','Unrated','TV-PG','TV-G','TV-14','TV-MA','NC-17','X'],value=np.nan)

# Convert Release dateimte into new columns for year, month, and week
imdb_df['Year'] = imdb_df['Released'].apply(lambda x:x.year)
imdb_df['Month'] = imdb_df['Released'].apply(lambda x:x.month)
imdb_df['Week'] = imdb_df['Released'].apply(lambda x:x.week)

# Convert the series to float
imdb_df['Runtime'] = imdb_df['Runtime'].apply(float)

# Take the imdbVotes formatted as string containing "N/A" and comma-delimited thousands, convert to float
imdb_df['imdbVotes'] = imdb_df['imdbVotes'].dropna().replace('N/A',np.nan).dropna().apply(lambda x:float(x.replace(',','')))

# Take the Metascore formatted as string containing "N/A", convert to float
# Also divide by 10 to make effect sizes more comparable
imdb_df['Metascore'] = imdb_df['Metascore'].dropna().replace('N/A',np.nan).dropna().apply(float)/10.

# Take the imdbRating formatted as string containing "N/A", convert to float
imdb_df['imdbRating'] = imdb_df['imdbRating'].dropna().replace('N/A',np.nan).dropna().apply(float)

# Create a dummy variable for English language
imdb_df['English'] = (imdb_df['Language']  == u'English').astype(int)
imdb_df['USA'] = (imdb_df['Country']  == u'USA').astype(int)

# Convert imdb_ID to int, set it as the index
imdb_df['imdbID'] = imdb_df['imdbID'].dropna().apply(int)
imdb_df = imdb_df.set_index('imdbID')


print("Joining data sets...")

## Joining Data Sets
df = imdb_df.join(ratings_df2,how='inner').reset_index()
df = pd.merge(df,numbers_df,left_on=['Title','Year'],right_on=['Movie','Year'])
df['Year'] = df['Released_x'].apply(lambda x:x.year)
df['Adj_Revenue'] = df.apply(lambda x:x['Revenue']*inflator[x['Year']],axis=1)
df['Adj_Budget'] = df.apply(lambda x:x['Budget']*inflator[x['Year']],axis=1)
df['Profit'] = df['Adj_Revenue'] - df['Adj_Budget']
df['ROI'] = df['Profit']/df['Adj_Budget']


print("Plotting!")

## Budgets differ
plt.figure(figsize=(8, 6), dpi=80)
fig, ax = plt.subplots()
ax.set_axis_bgcolor("#E0E0E0")

ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["left"].set_visible(False)

df['Adj_Budget'].groupby(df['rating']).agg(np.median).plot(kind='barh')
plt.xticks(np.arange(0e7,7e7,1e7),np.arange(0,70,10),fontsize=15)
plt.yticks(plt.yticks()[0],["Fewer than two women",
                             "Women don't talk to each other",
                             'Women only talk about men',
                             'Passes Bechdel Test'
                             ],fontsize=18)
plt.xlabel('Budget (2014 $millions)',fontsize=18)
plt.title('Median Budget for Films',fontsize=24)
plt.ylabel('')

ax.grid(b=True, axis='x', color='w', linestyle='-', linewidth=0.7)
ax.set_axisbelow(True)

plt.savefig('median_budget.png', bbox_inches='tight')
plt.clf()

bd_m = smf.ols(formula='np.log(Adj_Budget+1) ~ C(rating)', data=df).fit()
print bd_m.summary()

print "\n\nMovies passing every Bechdel dimension have budgets of ${:,} on average.".format(round(np.exp(bd_m.params['Intercept']+bd_m.params['C(rating)[T.3.0]']-1),2))
print "Movies failing every Bechdel dimension have budgets of ${:,} on average.".format(round(np.exp(bd_m.params['Intercept']-1),2))

## Earnings differ (ROI)
plt.figure(figsize=(8, 6), dpi=80)
fig, ax = plt.subplots()
ax.set_axis_bgcolor("#E0E0E0")

ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["left"].set_visible(False)

df['ROI'].groupby(df['rating']).agg(np.median).plot(kind='barh')
plt.yticks(plt.yticks()[0],["Fewer than two women",
                             "Women don't talk to each other",
                             'Women only talk about men',
                             'Passes Bechdel Test'
                             ],fontsize=18)
plt.xlabel('Return on Investment',fontsize=18)
plt.title('Median ROI for Films',fontsize=24)
plt.ylabel('')

ax.grid(b=True, axis='x', color='w', linestyle='-', linewidth=0.7)
ax.set_axisbelow(True)

plt.savefig('median_roi.png', bbox_inches='tight')
plt.clf()

## Earnings differ (Gross Profit)
plt.figure(figsize=(8, 6), dpi=80)
fig, ax = plt.subplots()
ax.set_axis_bgcolor("#E0E0E0")

ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["left"].set_visible(False)

df['Profit'].groupby(df['rating']).agg(np.median).plot(kind='barh')
plt.yticks(plt.yticks()[0],["Fewer than two women",
                             "Women don't talk to each other",
                             'Women only talk about men',
                             'Passes Bechdel Test'
                             ],fontsize=18)
plt.xlabel('Gross Profit',fontsize=18)
plt.title('Median Profit for Films',fontsize=24)
plt.ylabel('')

ax.grid(b=True, axis='x', color='w', linestyle='-', linewidth=0.7)
ax.set_axisbelow(True)

plt.savefig('median_profit.png', bbox_inches='tight')
plt.clf()

## Revenue
plt.figure(figsize=(8, 6), dpi=80)
fig, ax = plt.subplots()
ax.set_axis_bgcolor("#E0E0E0")

ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["left"].set_visible(False)

df['Adj_Revenue'].groupby(df['rating']).agg(np.median).plot(kind='barh')

plt.yticks(plt.yticks()[0],["Fewer than two women",
                             "Women don't talk to each other",
                             'Women only talk about men',
                             'Passes Bechdel Test'
                             ],fontsize=18)
plt.xlabel('Return on Investment',fontsize=18)
plt.title('Revenue for Films',fontsize=24)

plt.ylabel('')

ax.grid(b=True, axis='x', color='w', linestyle='-', linewidth=0.7)
ax.set_axisbelow(True)

plt.savefig('revenue.png', bbox_inches='tight')
plt.clf()

## Mean Metascore
plt.figure(figsize=(8, 6), dpi=80)
fig, ax = plt.subplots()
ax.set_axis_bgcolor("#E0E0E0")

ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["left"].set_visible(False)

df['Metascore'].groupby(df['rating']).agg(np.mean).plot(kind='barh')
plt.yticks(plt.yticks()[0],["Fewer than two women",
                             "Women don't talk to each other",
                             'Women only talk about men',
                             'Passes Bechdel Test'
                             ],fontsize=18)
plt.xlabel('Rating',fontsize=18)
plt.title('Mean Metascore',fontsize=24)
plt.xlim((5,6))
plt.ylabel('')

ax.grid(b=True, axis='x', color='w', linestyle='-', linewidth=0.7)
ax.set_axisbelow(True)

plt.savefig('mean_metascore.png', bbox_inches='tight')
plt.clf()

## Mean IMDB Rating
plt.figure(figsize=(8, 6), dpi=80)
fig, ax = plt.subplots()
ax.set_axis_bgcolor("#E0E0E0")

ax.spines["top"].set_visible(False)
ax.spines["bottom"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.spines["left"].set_visible(False)

df['imdbRating'].groupby(df['rating']).agg(np.mean).plot(kind='barh')
plt.yticks(plt.yticks()[0],["Fewer than two women",
                             "Women don't talk to each other",
                             'Women only talk about men',
                             'Passes Bechdel Test'
                             ],fontsize=18)
plt.xlabel('Rating',fontsize=18)
plt.title('Mean IMDB rating',fontsize=24)
plt.xlim((6,7))
plt.ylabel('')

ax.grid(b=True, axis='x', color='w', linestyle='-', linewidth=0.7)
ax.set_axisbelow(True)

plt.savefig('mean_imdb_rating.png', bbox_inches='tight')
plt.clf()
