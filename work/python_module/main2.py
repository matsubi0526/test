# -*- coding: utf-8 -*-
# 2025-12-01
# created by MATSUBA Fumitaka

import os
import sys
import numpy as np

from my_module import my_function

def main():
    print("this is a test")
    data = my_function.getdata_from_file("data.dat")
    print(data.shape)
    my_function.quicklook(data,-3,3)

if __name__ == "__main__":
    main()
