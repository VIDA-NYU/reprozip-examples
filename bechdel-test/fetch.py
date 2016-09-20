import numpy as np
import pandas as pd
import json, string
from bs4 import BeautifulSoup
import csv
import requests


print("Getting revenue data from the-numbers.com...")

# Revenue data taken from scraping http://www.the-numbers.com/movies/#tab=letter
revenue_df_list = list()

for character in string.printable[1:36]:
    url = 'http://www.the-numbers.com/movies/letter/{0}'.format(character)
    print("  %s" % url)
    soup = BeautifulSoup(requests.get(url).text, 'html5lib')
    archive = pd.read_html(soup.findAll('table')[0].encode('latin1'),header=0,flavor='bs4')[0]
    archive.columns = ['Released','Movie','Genre','Budget','Revenue','Trailer']
    archive['Released'] = pd.to_datetime(archive['Released'],format=u"%b\xa0%d,\xa0%Y",errors='coerce')
    archive = archive.replace([u'\xa0',u'nan'],[np.nan,np.nan])
    archive['Budget'] = archive['Budget'].dropna().astype('str').str.replace('$','').apply(lambda x:int(x.replace(',','')))
    archive['Revenue'] = archive['Revenue'].dropna().astype('str').str.replace('$','').apply(lambda x:int(x.replace(',','')))
    archive['Year'] = archive['Released'].apply(lambda x:x.year)
    archive.dropna(subset=['Movie'],inplace=True)
    revenue_df_list.append(archive)

numbers_df = pd.concat(revenue_df_list)
numbers_df.reset_index(inplace=True,drop=True)
numbers_df.to_csv('revenue.csv',encoding='utf8')


print("Getting inflation data from bls.gov...")

# Inflation data from BLS, http://www.bls.gov/developers/home.htm
#years = {}

#headers = {'Content-type': 'application/json'}
#for year in xrange(1913, 2024-9, 10):
#    data = json.dumps({"seriesid": ['CUUR0000SA0'], "startyear": "%d" % year, "endyear": "%d" % (year + 9)})
#    p = requests.post('http://api.bls.gov/publicAPI/v2/timeseries/data/', data=data, headers=headers)
#    json_data = json.loads(p.text)

#    for e in json_data['Results']['series'][0]['data']:
#        if e['periodName'] == 'January':
#            years[int(e['year'])] = e['value']

#with open('cpi.csv', 'wb') as fp:
#    writer = csv.writer(fp)
#    writer.writerow(["Year", "Annual"])
#    for year in sorted(years.keys()):
#        writer.writerow([year, years[year]])


print("Getting Bechdel Test data from bechdeltest.com...")

# Bechdel Test data from BechdelTest.com's API
# Documentation here: http://bechdeltest.com/api/v1/doc#getMovieByImdbId
movie_ids = requests.get('http://bechdeltest.com/api/v1/getAllMovieIds').json()
imdb_ids = [movie[u'imdbid'] for movie in movie_ids]
print("There are {0} movies in the Bechdel test corpus".format(len(imdb_ids)))

ratings = dict()
exceptions = list()
for num, imdb_id in enumerate(imdb_ids):
    if num % 200 == 0:
        print("  got %d" % num)
    try:
        ratings[imdb_id] = requests.get('http://bechdeltest.com/api/v1/getMovieByImdbId?imdbid={0}'.format(imdb_id)).json()
    except Exception:
        exceptions.append(imdb_id)
        pass

with open('bechdel.json', 'wb') as f:
    json.dump(ratings.values(), f)


print("Getting data from OMDBAPI...")

# Additional data from OMDBAPI
imdb_data = dict()
exceptions = list()
for num, imdb_id in enumerate(imdb_ids):
    if num % 200 == 0:
        print("  got %d" % num)
    try:
        imdb_data[imdb_id] = requests.get('http://www.omdbapi.com/?i=tt{0}'.format(imdb_id)).json()
    except Exception:
        exceptions.append(imdb_id)
        pass

with open('imdb_data.json', 'wb') as f:
    json.dump(imdb_data.values(), f)
