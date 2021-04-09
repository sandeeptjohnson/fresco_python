import urllib.request as ulib
import re
import csv

url="http://fresco-movies.surge.sh/"
page = ulib.urlopen(url)
html_bytes = page.read()
html = html_bytes.decode("utf-8")

#movie name
movieName=[str(s[1]) for s in re.findall('<a href="(.*?)">(.*?)</a>(\s+)</h3>',html)]

#movie rating
rating=[float(s) for s in re.findall('<span class="certificate">(.*?)</span>',html)]

#duration
duration=[str(s) for s in re.findall('<span class="runtime">(.*?)</span>',html)]

#genre
genre=[str(s) for s in re.findall('<span class="genre">(.*?)</span>',html)]

#description
description=[str(s) for s in re.findall('<p class="text-muted">(.*?)</p>',html)]

#director
director=[str(s[1]) for s in re.findall('Director:(\s+)<a href="http://127.0.0.1:5000/#">(.*?)</a>',html)]

#votes
votes=[int(s) for s in re.findall('<span name="nv" data-value="41436">(.*?)</span>',html)]

#combine
data = list(zip(movieName, duration, genre, rating, description, director, votes))

#write to file
with open('data.csv', 'a') as csvfile:
  spamwriter = csv.writer(csvfile, delimiter=',', quoting=csv.QUOTE_MINIMAL)
  for row in data:
    row = list(row)
    spamwriter.writerow(row)
