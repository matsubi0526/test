README.txt

1. 資料を構成するファイル

  この資料は5個のファイルにより構成されています。

  地表ジオポテンシャル高度データ
    (a) "TOPO.LFM_2K"              局地数値予報モデルGPV用
    (b) "TOPO.MSM_5K"              メソ数値予報モデルGPV用

  海陸分布データ
    (a) "LANDSEA.LFM_2K"           局地数値予報モデルGPV用
    (b) "LANDSEA.MSM_5K"           メソ数値予報モデルGPV用

   このファイル
        "README.txt"  このファイル

（注）数値予報モデルで使用する高度データを「地表ジオポテンシャル高度データ」
  と呼び，国土庁及び国土地理院が公開している地図や標高データそのもの
  と混同しないようにしています。ただし，以下の文中では煩雑さを避ける
  ため「高度データ」と呼びます。


2. データの値

  高度データは格子点の高度。単位は m。
  海陸分布データは、水域を０，陸域を１とした海陸の割合。
  なお、局地数値予報モデルGPVでは領域範囲外となる格子点があります。
  高度データについては,数値予報モデルの領域範囲外となる格子点については高度を-999.0mに設定してあります。
  海陸分布データについては,数値予報モデルの領域範囲外となる格子点については-1が設定してあります。

  気象業務支援センターからユーザに提供されるGPVデータの座標系は、
  各数値予報モデルの数値計算で使用されている座標系と異なっているため、
  数値予報モデルが使用している値を内挿しています。

3. ファイル形式

  (1) データ形式
    4バイト実数(IEEE754)の2次元配列です。
    バイトの並びはbig endianです。

 (2) 座標系
    等緯度経度格子座標系です。

    (a) 局地数値予報モデルGPV
       格子数：  東西方向   1201    南北方向   1261
       格子間隔：東西方向 0.025度  南北方向 0.02度
       先頭の格子点：北緯47.6度  東経120度 

    (b) メソ数値予報モデルGPV
       格子数：  東西方向   481    南北方向   505
       格子間隔：東西方向 0.0625度  南北方向 0.05度
       先頭の格子点：北緯47.6度  東経120度 

  (3) データ格納順序
    先頭の格子点から緯度の同じ格子点を経度方向東向きに格納し、
  経度方向に１周する度、そのすぐ南の緯度で同様に繰り返し格納しています。

4.著作権について

  ・この媒体に含まれる数値データは著作権の対象ではありませんので、自由に利用できます。
  ・この媒体に含まれるサンプルプログラムや技術資料は、複製、公衆送信、翻訳・変形等の翻案等、自由に利用できます。
  商用利用も可能です。利用する際は、「気象庁提供」を明示してください。編集・加工等して利用する場合は、出典とは別に、
  編集・加工等を行ったことを記載してください。


5.免責について

  ・国は、利用者がこの媒体の内容を用いて行う一切の行為（内容を編集・加工等した情報を利用することを含む。）について
  何ら責任を負うものではありません。
  ・この媒体の内容については、可能な限り品質管理に努めていますが、後日修正される場合があります。