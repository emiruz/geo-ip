FROM openresty/openresty:alpine
COPY ipdb.csv ipdb.csv
COPY geoip.lua geoip.lua
COPY nginx.conf /etc/nginx/conf.d/default.conf