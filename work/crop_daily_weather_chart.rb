# -*- coding: utf-8 -*-
# 2025-11-28
# created by MATSUBA Fumitaka
# Last-revised 2025-11-29

if __FILE__ == $0 then
  width = 143
  height = 199
  
  wtable = [0,1,2,3].collect{|ii| 20+width*ii}
  htable = [0,1,2,3].collect{|ii| 822-height*ii}

  target = "2507"
  
  for day in 1..31
    sday = sprintf("%02d",day)
    page = day < 16 ? 0 : 1
    x0 = wtable[(day%16)%4]; x1 = x0+width
    y1 = htable[(day%16)/4]; y0 = y1-height
    output = "figs/#{target}_#{sday}.png"
    p cmd1 = %Q[pdfcrop --bbox "#{x0} #{y0} #{x1} #{y1}" #{target}.pdf cropped.pdf]
    p cmd2 = "convert -density 300 cropped.pdf[#{page}] -background white -alpha remove -trim +repage #{output}" 
    system(cmd1)
    system(cmd2)
  end
end
