About `source_system_tab`

``` python
len(set(Counter(df['source_system_tab'])))
# 10
Counter(df['source_system_tab'])
'''
Counter({
  'my library': 3684730, 
  'discover': 2179252, 
  'search': 623286, 
  'radio': 476701, 
  'listen with': 212266, 
  'explore': 167949, 
  nan: 18371, 
  'null': 6478, 
  'notification': 6185, 
  'settings': 2200
})
'''
```



About `source_screen_name`

``` python
len(set(Counter(df['source_screen_name'])))
# 21
Counter(df['source_screen_name'])
'''
Counter({
  'Local playlist more': 3228202, 
  'Online playlist more': 1294689, 
  'Radio': 474467, 
  'Album more': 420156, 
  nan: 414804, 
  'Search': 298487, 
  'Artist more': 252429, 
  'Discover Feature': 244246, 
  'Discover Chart': 213658, 
  'Others profile more': 201795, 
  'Discover Genre': 82202, 
  'My library': 75980, 
  'Explore': 72342, 
  'Unknown': 54170, 
  'Discover New': 15955, 
  'Search Trends': 13632, 
  'Search Home': 13482, 
  'My library_Search': 6451, 
  'Self profile more': 212, 
  'Concert': 47, 
  'Payment': 12
})
'''
```



About `source_type`

``` python
len(set(Counter(df['source_type'])))
# 13
Counter(df['source_type'])
'''
Counter({
  'local-library': 2261399, 
  'online-playlist': 1967924, 
  'local-playlist': 1079503, 
  'radio': 483109, 
  'album': 477344, 
  'top-hits-for-artist': 423614, 
  'song': 244722, 
  'song-based-playlist': 210527, 
  'listen-with': 192842, 
  nan: 21539, 
  'topic-article-playlist': 11194, 
  'artist': 3038, 
  'my-daily-playlist': 663
})
'''
```



About `city`

``` python
len(set(Counter(df['city'])))
# 21
Counter(df['city'])
'''
Counter({
  1: 2621293, 
  13: 1144863, 
  5: 830128, 
  4: 545820, 
  15: 484078, 
  22: 460330, 
  6: 275781, 
  14: 236639, 
  12: 147133, 
  9: 95237, 
  8: 85734, 
  18: 81780, 
  11: 71542, 
  10: 69158, 
  21: 67097, 
  3: 63555, 
  17: 44688, 
  7: 31621, 
  16: 7887, 
  19: 6961, 
  20: 6093
})
'''
```



About `registered_via`

``` python
len(set(Counter(df['registered_via'])))
# 5
Counter(df['registered_via'])
'''
Counter({
  9: 2814535, 
  7: 2551743, 
  3: 1250790, 
  4: 745251, 
  13: 15099
})
'''
```



About `language`

``` python
len(set(Counter(df['language'])))
# 160
# with dummies: 10, nan: 150
Counter(df['language'])
'''
Counter({
  3.0: 4044643, 
  52.0: 1864789, 
  31.0: 656623, 
  -1.0: 308752, 
  17.0: 245136, 
  10.0: 171904, 
  24.0: 78621, 
  59.0: 4193, 
  45.0: 2397, 
  38.0: 210, 
  nan: 1 # It got 150 of nans...
})
'''
```



Songs

```python
len(set(Counter(df['song_id'])))
# 359966 -> Songs id
len(set(Counter(df['name']))) 
# 234145 -> Songs name
# It's wired...obviously they didn't provide a well mapping from id to name
```



Others

``` python
len(set(Counter(df['genre_ids'])))
# 573 -> Types of music including duplicated
# 167 -> identical
len(set(Counter(df['artist_name'])))
# 40583 -> Singers
```



Members

```python
len(set(df['msno']))
# 30755
len(df['msno'])
# 7377418
# Which means we can try to know about some specific members with his or her taste or habit...
```

