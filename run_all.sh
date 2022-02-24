#!/bin/bash 

# retrieve the necessary data:
curl "https://opendata.fcc.gov/api/views/pp56-kd4g/rows.csv?accessType=DOWNLOAD&sorting=true" -o fcc.csv
bzip2 fcc.csv 
aws s3 cp s3://ookla-open-data/shapefiles/performance/type=fixed/year=2021/quarter=4/2021-10-01_performance_fixed_tiles.zip .
wget ftp://ftp2.census.gov/geo/tiger/GENZ2019/shp/cb_2019_us_tract_500k.zip

mkdir -p data
mv fcc.csv.bz 2021-10-01_performance_fixed_tiles.zip cb_2019_us_tract_500k.zip data/

# self-explanatory
./fcc_redux.py
./fcc_agg.py

./get_acs.py

./ookla_agg.py

./merge.py
# --> creates broadband.geojson and broadband.csv.gz

