# -*- coding: utf-8 -*-
# 2024-05-18
# created by MATSUBA Fumitaka
# 短期予報解説資料をYYYYMMディレクトリに移動させるスクリプト

require 'fileutils'
module Define
  module_function
  def extract_unique_prefixes
    # カレントディレクトリ内のPDFファイル名を取得
    pdf_files = Dir.glob('*.pdf')
    
    # 先頭が12桁の数字になっているファイル名だけを抽出し、
    # 先頭6桁を取り出す
    prefixes = pdf_files.map do |filename|
      if filename.match?(/^\d{12}/)
        filename[0,6]
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
      
      # カレントディレクトリ内の該当PDFファイル名を取得
      pdf_files = Dir.glob("#{dir}*.pdf")
      pdf_files.each do |pdffile|
        # タイムスタンプを取得する
        atime = File.atime(pdffile)
        mtime = File.mtime(pdffile)
        
        # ファイルをディレクトリに移動させる
        destination = File.join(dir,File.basename(pdffile))
        FileUtils.mv(pdffile,destination)

        # タイムスタンプを元に戻す
        File.utime(atime,mtime,destination)
      end
    end
  end
end
