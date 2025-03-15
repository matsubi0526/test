# -*- coding: utf-8 -*-
# 2025-03-15
# created by MATSUBA Fumitaka
# 速報天気図(SPAS)をYYYYMMディレクトリに移動させるスクリプト

require 'fileutils'
module Define
  module_function
  def extract_unique_prefixes
    # カレントディレクトリ内のPNGファイル名を取得
    png_files = Dir.glob('*.png')
    
    # SPASの日付部分を抽出する
    prefixes = png_files.map do |filename|
      match = filename.match(/_(\d{14})_/)
      if match
        match[1][0,6]
      end
    end.compact
    
    # 重複を削除して配列として返す
    return prefixes.uniq
  end
end

if __FILE__ == $0 then
  # カレントディレクトリのパスを取得し移動する
  p current_directory = Dir.pwd
  Dir.chdir(current_directory)
  
  dirlist = Define::extract_unique_prefixes
  unless dirlist.empty? then
    p dirlist
    dirlist.each do |dir|
      # ディレクトリが存在しない場合に作成する
      unless Dir.exist?(dir)
        FileUtils.mkdir_p(dir)
        puts "ディレクトリ #{dir} を作成しました"
      end
      
      # カレントディレクトリ内の該当PNGファイル名を取得
      png_files = Dir.glob("*_#{dir}*.png")
      png_files.each do |pngfile|
        # タイムスタンプを取得する
        atime = File.atime(pngfile)
        mtime = File.mtime(pngfile)
        
        # ファイルをディレクトリに移動させる
        destination = File.join(dir,File.basename(pngfile))
        FileUtils.mv(pngfile,destination)

        # タイムスタンプを元に戻す
        File.utime(atime,mtime,destination)
      end
    end
  end
end
