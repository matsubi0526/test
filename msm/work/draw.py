# -*- coding: utf-8 -*-
# 2024-04-14
# created by MATSUBA Fumitaka
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from cartopy.mpl.ticker import LongitudeFormatter, LatitudeFormatter
import warnings
warnings.filterwarnings('ignore')

# --- MSM領域(等緯度経度)の描画 --- #
lon = 120 + 0.0625*np.arange(481)
lat = 47.6 - 0.05*np.arange(505)
lons,lats = np.meshgrid(lon,lat)

nlons = np.concatenate([lons[0,:],lons[:,-1],lons[-1,::-1],lons[::-1,0]])
nlats = np.concatenate([lats[0,:],lats[:,-1],lats[-1,::-1],lats[::-1,0]])
print(nlons)
print(nlats)

# --- MAIN ROUTINE --- #
fig = plt.figure()
proj = ccrs.LambertConformal(central_longitude=135.0,
                             central_latitude=35.0)
ax = fig.add_subplot(111,projection=proj)
ax.set_extent([110, 160, 15, 55])
ax.set_title("projection='ccrs.LambertConformal', ")

gl = ax.gridlines(crs=ccrs.PlateCarree(), draw_labels=True,
                  x_inline = False, y_inline = False,
                  linewidth=1, linestyle=':', color='k', alpha=0.8)
gl.right_labels = gl.top_labels = False
gl.xlocator = mticker.FixedLocator(np.arange(-180,180,10))  # 経度線
gl.ylocator = mticker.FixedLocator(np.arange(-90,90,10))    # 緯度線

ax.add_feature(cfeature.LAND)
ax.add_feature(cfeature.OCEAN)
ax.add_feature(cfeature.COASTLINE, linewidth=0.8)

ax.plot(nlons,nlats,color="red",transform=ccrs.PlateCarree(),
        label="MSM latlon(5km)")
plt.legend()

#plt.show()
plt.savefig("figure.png",dpi=150)
plt.close
