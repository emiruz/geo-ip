# Overview

This service includes GeoLite2 data created by MaxMind, available from http://www.maxmind.com.

Specifically, country IP data is used available here:

    http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV.zip

This simple micro-service works as follows:

0. Load the country IP resolution table into memory.
1. Take an IP address as a query string argument.
2. Convert the IP address into decimal form.
3. Use a binary search to find the country corresponding to the IP range.
4. Return the country as a JSON or a default value if it can't be found.

# Prerequisites

  Docker

# Build

    sudo make build

# Run

    sudo make deploy

If you like you can override variables in the Makefile like this:

    sudo make deploy IMGNAME=<image name> PORT=<some port>

# Usage

For example:

    curl -s http://localhost:5500/?ip=23.211.22.1

Returns:

    {"country":"US"}

If the associated country cannot be found. Then the following is returned:

    {"country":"UNKNOWN"}

If an IP is invalid or is not specified a error code 500 is returned along with a
message.
