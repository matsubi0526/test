# -*- coding: utf-8 -*-
# 2022-12-01 created by MATSUBA Fumitaka
# 2022-12-04 revised
#
import sys
import numpy as np
import numpy.ma as ma
import matplotlib.pyplot as plt

mdl = sys.argv[1] # MSM/LFM
mdl = mdl.upper() # 大文字にする
if mdl == "MSM":
    nx = 481; ny = 505
    fname1 = "TOPO.MSM_5K"; fname2 = "LANDSEA.MSM_5K"
elif mdl == "LFM":
    nx = 1201; ny = 1261
    fname1 = "TOPO.LFM_2K"; fname2 = "LANDSEA.LFM_2K"
else:
    print("sys.argv must be MSM/msm or LFM/lfm")
    sys.exit()
   
f1 = open(fname1,"rb")
a1 = np.fromfile(f1,dtype='>f') # big-endian float32
b1 = a1.reshape((nx,ny),order="F").T # transpose
zs = ma.masked_where(b1==-999.0,b1) # 欠損値の設定

f2 = open(fname2,"rb")
a2 = np.fromfile(f2,dtype='>f') # big-endian float32
b2 = a2.reshape((nx,ny),order="F").T # transpose
sl = ma.masked_where(b2==-1.0,b2) # 欠損値の設定

zs_maxmin = "max = {:.5f} / min = {:.5f} / count_valid = {:7d}".format(
    np.amax(zs),np.amin(zs),zs.count())
sl_maxmin = "max = {:.2f} / min = {:.2f} / count_valid = {:7d}".format(
    np.amax(sl),np.amin(sl),sl.count())

tx = nx/2; ty = -ny/8

fig = plt.figure(figsize=(10,5))

ax1 = plt.subplot(1,2,1)
clr = ax1.imshow(np.flipud(zs),cmap="terrain",origin="lower",vmax=2500)
cbar = plt.colorbar(clr,shrink=0.6,extend='max')
ax1.set_title(fname1)
ax1.text(tx,ty,zs_maxmin,ha='center',color='blue')

ax2 = plt.subplot(1,2,2)
clr = ax2.imshow(np.flipud(sl),cmap="gist_earth",origin="lower",vmax=1)
cbar = plt.colorbar(clr,shrink=0.6,extend='neither')
ax2.set_title(fname2)
ax2.text(tx,ty,sl_maxmin,ha='center',color='blue')

plt.savefig("{:s}_topo_v3.png".format(mdl),dpi=120)
plt.close
