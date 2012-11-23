class BobbReqController < ApplicationController

  # ユーザ名登録
  def regist_user
      name = params[:user_name]
      if name != nil then
          # DBにユーザ名をインサートして、インサートしたレコードを取得
          userLine = User.create(:user_name => name)
          
          # 登録した情報を全てJSON形式で端末へ返却する
          render :json => userLine
      end
      
  end

  # アクセスログ書き込み
  def access_log
      id = params[:user_id]
      level = params[:user_level]
      transactionId = params[:transaction_id]
      
      if (id != nil) && (level != nil) && (transactionId != nil) then
          # DBにユーザ名をインサートして、インサートしたレコードを取得
          logLine = Access.create(
          :user_id => id,
          :user_level => level,
          :access_time => Time.now,
          :transaction_id => transactionId)
          
          # 登録した情報を全てJSON形式で端末へ返却する
          render :json => logLine
      end
      
  end

  # 対戦ユーザ一覧要求
  def online_user_list
    
    #アクセスログのうち、15分以内の条件で引っ張る
    time = Time.now
#    accesslog = Access.find(:all, :conditions => [" access_time >= '#{Time.utc(time.year, time.month, time.day, time.hour, time.min - 15)}'"])
#    accesslog = Access.find(:all, :conditions => [" access_time >= '?'", Time.utc(time.year, time.month, time.day, time.hour, time.min - 15)])
    accesslog = Access.find(:all, :conditions => [" access_time >= '#{time - (60 * 15)}'"])
    
    #将来的にはLVでも絞れるようにしたい
    
    # 条件検索で取得した情報を全てJSON形式で端末へ返却する
    if (accesslog == nil)
      render :json => "nodata"
    end
    render :json => accesslog
    
  end

  # 対戦依頼
  def request_battle
  end

  # 対戦依頼への応答
  def response_battlereq
  end

  # 対戦ステータス確認
  def battle_status
  end

  # 対戦相手カード情報取得要求
  def enemy_using_card
  end

  # 対戦使用カード情報登録
  def regist_using_card
  end

  # 対戦時選択カード情報登録
  def regist_selected_card
  end

  # 対戦時選択カード情報取得
  def enemy_selected_card
  end

  # 対戦終了/中断通知
  def battle_stop
  end
  
  
  #-----------------------------
  #  以下、サンプルをほぼ張り付け。解析が必要  
  #-----------------------------
  #GCM送信用のインナークラス  
  require 'json'
  require 'net/https'

  class GcmSender

  # GCMサーバの接続先 (https://android.googleapis.com/gcm/send)
  GCM_HOST = "android.googleapis.com"
  GCM_PATH = "/gcm/send"
  
  # Registration ID (Androidアプリ実行時にGCMサーバから発行されたもの)
  REG_ID = "APA91bHYW76k4HUVUMQM7zqUbbB83ysRzXJkPsh6zn6HlAZm1IBdWKTXHFQEP4u41vu7hdTvfNwTPDvfNaojbGhRFPktf4LTkKg6ciLDSqmMq7isz8QTbCALFAwEjUM8bLghwUotW5rcIvXHd5VogU7OJs7C_AD2-Q"
  # APIキー (Google APIs Consoleで発行されたもの)
  API_KEY = "AIzaSyCDMlzrcinT_WgnDd1frr8O76kTqIGvMmA"

    def send
      
        # 送信するメッセージの内容
        message = {
          "registration_ids" => [REG_ID],
          "collapse_key" => "collapse_key",
          "delay_while_idle" => false,
          "time_to_live" => 60,
          "data" => { "message" => "GCM Demo",
                      "detail" => "Hello world"}
        }
        
        # HTTPS POST実行
        http = Net::HTTP.new(GCM_HOST, 443);
        http.use_ssl = true
        http.start{|w|
          response = w.post(GCM_PATH,
            message.to_json + "\n",
            {"Content-Type" => "application/json",
             "Authorization" => "key=#{API_KEY}"})
          puts "response code = #{response.code}"
          puts "response body = #{response.body}"
          
        }
    end
  end

end
