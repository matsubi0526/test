#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 2022-04-23
# created by MATSUBA Fumitaka
# --- DOWNLOADING THE LATEST WEATHER MAP FROM www.jma.go.jp ---
#
# Usage:
# $ python3 download_latest_map.py
#
import requests
import json
import subprocess
baseurl = "https://www.jma.go.jp/bosai/weather_map/data/png"
map_url = "https://www.jma.go.jp/bosai/weather_map/data/list.json"
map_json = requests.get(map_url).json()
map_png = map_json['near']['now'][-1]
map_url = "/".join([baseurl,map_png])
subprocess.run(["wget","-N",map_url])
