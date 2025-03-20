#!/bin/bash
# 2024-01-27
# created by MATSUBA Fumitaka
# sample plot on gnuplot

FUNC="0.2*Math::exp(-x**3/10**5)"
ruby <<-EOF
f = File.open("data.txt","w")
xmin = 1; xmax = 101; nmax = 100000
dx = (xmax-xmin).to_f/nmax
for ii in 1..nmax
  x = xmin + ii*dx
  y = ${FUNC:?} 
  f.puts("#{x} #{y}")
end
f.close 
EOF

VERSION=$(gnuplot -V)
OUTPNG=test_${VERSION// /_}_$(hostname).png

gnuplot <<-EOF
set terminal pngcairo
set output "${OUTPNG:?}"
set style line 1 lt 1 lc rgb 'magenta' lw 3 pt 7
set xlabel "f(X)"
set ylabel "X-COORDINATE"
set title "TEST PLOT ON GNUPLOT (${VERSION:?})"
set logscale x
plot "data.txt" using 2:1 w l ls 1 ti "${FUNC//Math::/}"
EOF

rm -f data.txt
