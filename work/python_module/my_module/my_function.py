# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

def main():
    print("this is a my_function.py test")

def quicklook(data,cb_min,cb_max):
    """
    this method is quoted from https://qiita.com/AnchorBlues/items/0dd1499196670fdf1c46  
    """
    XX,YY = np.meshgrid(
        np.arange(data.shape[0]),
        np.arange(data.shape[1])
    )
    fig = plt.figure()
    ax1 = fig.add_subplot(1,1,1)
    div = 20.0
    delta = (cb_max - cb_min)/div
    interval = np.arange(cb_min,abs(cb_max)*2+delta,delta)[0:int(div)+1]
    im1 = ax1.contourf(XX,YY,data.T,interval,cmap="jet")
    plt.colorbar(im1,ax=ax1)
    plt.show()
    
def getdata_from_file(filename):
    f = open(filename,"rb")
    nx,ny = np.fromfile(f,">i4",2)         # big-endian int32
    a = np.fromfile(f,">f8", nx*ny)        # big-endian float64
    return a.reshape((nx,ny),order="F")
    
if __name__ == "__main__":
    main()
