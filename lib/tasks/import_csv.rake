require 'csv'

namespace :import_csv do

  desc "CSVデータをインポートするタスク"
  task users: :environment do
    # CSVファイルパス
    path = "db/csv_data/csv_data.csv"
    # 配列格納
    list = []
    # データを取得
    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end


    puts "インポート処理を開始"

    # 例外処理
    begin
      User.transaction do
        User.create!(list)
      end
      puts "インポート完了!!".green
    rescue => e
      # 例外発生の場合
      puts "#{e.class}: #{e.message}".red
      puts "-------------------------"
      puts e.backtrace
      puts "-------------------------"
      puts "インポートに失敗".red
    end

  end

end

