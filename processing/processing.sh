ogr2ogr -f GeoJSON input_data/trees.geojson TOPO_TREE_WGS84.shp

tippecanoe -f -zg -o  toronto-trees-2015.pmtiles --drop-densest-as-needed --extend-zooms-if-still-dropping input_data/trees.geojson

tippecanoe -f -zg -o toronto-trees-2015.pmtiles --drop-densest-as-needed --extend-zooms-if-still-dropping --full-detail 14 -r1 input_data/trees.geojson
