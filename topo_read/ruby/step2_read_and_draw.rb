# -*- coding: utf-8 -*-
# 2022-12-04
# created by MATSUBA Fumitaka
require 'numru/ggraph'
include NumRu

def GGraph::annotate(str_ary)
  lclip = DCL.sgpget('lclip')
  DCL.sgpset('lclip',nil)
  lnum = 0
  str_ary.each{ |str|lnum += 1 }
    charsize = 0.7 * DCL.uzpget('rsizec1')
  dvx = 0.01
  dvy = charsize*1.5
  raise TypeError,"Array expected" if ! str_ary.is_a?(Array)
  vxmin,vxmax,vymin,vymax = DCL.sgqvpt
  vx = 0.70
  vy = 0.045 + (lnum-1)*dvy
  str_ary.each{|str|
    DCL::sgtxzv(vx,vy,str,charsize,0,-1,1)
    vy -= dvy
  }
  DCL.sgpset('lclip',lclip)
  nil
end

module Define
  module_function
  def read2D_binary2data(file)
    case file
    when String then
      file1 = File.open(file, 'rb') # binary mode
    when File then
      path = file.path
      file.close      
      file1 = File.open(path, 'rb') # binary modeで再度オープン
    end
    str = file1.read

    # ---- binary file ----
    # str[0,4]: header (size information) = 4byte*2
    # str[4,8]: nx, ny
    # str[12,4]: footer (size information)
    #
    # str[16,4]: header (size information) = 4byte*nx*ny
    # str[20,dnum]: nadata(nx,ny)
    # str[20+dnum,4]: footer (size information)

    if (str[0,4].unpack("l")[0] == 8 && str[12,4].unpack("l")[0] == 8) then
      nx, ny = str[4,8].unpack("l*")
      snum = 4*nx*ny # 単精度実数は4byte
      dnum = 8*nx*ny # 倍精度実数は8byte
      if (str[16,4].unpack("l")[0] == snum) then
        nadata = NArray.to_na(str[20,snum], NArray::SFLOAT, nx, ny)
      elsif (str[16,4].unpack("l")[0] == dnum) then
        nadata = NArray.to_na(str[20,dnum], NArray::FLOAT, nx, ny)
      else
        raise "DATA PART BINARY SOMETHING'S WRONG!"
      end
    else
      raise "HEADER PART BINARY SOMETHING'S WRONG!"
    end  
    return nadata
  end
  def mk_gphys2D(nadata)
    nx, ny = nadata.shape
    
    nax = NArray.sfloat(nx).indgen! + 1
    hax = {'long_name'=>'x-coordinate', 'units'=>'grid number'}
    vax = VArray.new(nax, hax, 'x')
    axx = Axis.new.set_pos(vax)
    
    nay = NArray.sfloat(ny).indgen! + 1
    hay = {'long_name'=>'y-coordinate', 'units'=>'grid number'}
    vay = VArray.new(nay, hay, 'y')
    axy = Axis.new.set_pos(vay)
    
    hadata = {'long_name'=>'', 'units'=>''}
    vadata = VArray.new(nadata, hadata, 'data')
    gpdata = GPhys.new(Grid.new(axx, axy), vadata)
    return gpdata
  end
end
if __FILE__ == $0 then
  file = "topo.dat"
  nadata = Define::read2D_binary2data(file)
  nadata = nadata.reverse(-1) # y軸を逆転

  # 欠損値の設定
  rmiss = -999.0
  mask = nadata.ne(rmiss)
  nadata = NArrayMiss.to_nam(nadata,mask)
  
  gpdata = Define::mk_gphys2D(nadata)
  
  max = nadata.max
  min = nadata.min

  smax = sprintf("%11.5f",max)
  smin = sprintf("%11.5f",min)

  # 欠損ではない格子数をカウントする
  nvalid = nadata.count_valid
  
  # --- MAIN ROUTINE --- #
  iws = (ARGV[0]||(puts ' WORKSTATION ID (I) ?;'; DCL::sgpwsn; gets)).to_i
  fname = ARGV[1] || "topo.dat"
  GGraph.startup 'iws'=>iws,'colormap'=>1
  GGraph.margin_info(nil)
  DCLExt.sg_set_params 'lcntl'=>true
  opt_tone = {
    'min'=>0,'max'=>3000,'interval'=>100
  }
  GGraph.tone gpdata,true,opt_tone
  GGraph.color_bar
  GGraph.title(fname)

  str_ary = ["max=#{smax}","min=#{smin}","count_valid=#{nvalid}"]
  GGraph.annotate(str_ary)
  
  GGraph.close
end
