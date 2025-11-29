# -*- coding: utf-8 -*-
# 2025-11-28
# created by MATSUBA Fumitaka

if __FILE__ == $0 then
  wtable = [55,455,855,1255]
  htable = [55,605,1155,1705]

  #target = "2507"
  target = "2508"
  
  for day in 1..31
    sday = sprintf("%02d",day)
    page = day < 16 ? 1 : 2
    ww = wtable[(day%16)%4]
    hh = htable[(day%16)/4]
    output = "figs/#{target}_#{sday}.png"
    p cmd = "convert #{target}_ページ_#{page}.png -crop 400x550+#{ww}+#{hh} #{output}"
    system(cmd)
  end
end
