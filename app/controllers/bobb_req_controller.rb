# coding: utf-8

class BobbReqController < ApplicationController
  
  
  def index
        @users = User.all
        @accessList = Access.all
        @BattleRecords = BattleRecord.all
        
  end

  # ユーザ名登録
  def regist_user
      name = params[:user_name]
      if name != nil then
        
        userLine = User.all
          # DBにユーザ名をインサートして、インサートしたレコードを取得
          userLine = User.create(:user_name => name)
          
          # 登録した情報を全てJSON形式で端末へ返却する
          
          jsonNanalyzed = ActiveSupport::JSON.encode(userLine)
          render :text => jsonNanalyzed
#          render :json => userLine
      end
      
  end

  # アクセスログ書き込み
  def access_log
      id = params[:user_id]
      name = params[:user_name]
      level = params[:user_level]
      transactionId = params[:transaction_id]
      
      if (id != nil) && (name != nil) && (level != nil) && (transactionId != nil) then
          # DBにユーザ名をインサートして、インサートしたレコードを取得
          logLine = Access.create(
          :user_id => id,
          :user_name => name,
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
    render :json => accesslog
    
  end

  # 対戦依頼
  def request_battle
      req_user_id = params[:req_user_id]
      res_user_id = params[:res_user_id]
      reg_id = params[:registration_id]
  
      if ((req_user_id != nil) && (res_user_id != nil) && (reg_id != nil)) then
          #--------------------
          #  対戦一覧に1行追加
          #--------------------
          # ステータスを0に設定　依頼中(0)、開始(1)、拒否(2)、終了(3)
          battle_status = 0
          # 対戦履歴にデータインサート
          logLine = BattleRecord.create(
            :req_user_id => req_user_id,
            :res_user_id => res_user_id,
            :battle_status => battle_status)
          
          #対戦要求をPUSH
          sender = GcmSender.new
          sender.send(reg_id)
          
          # ステータス情報をJSON形式で端末へ返却する
          render :json => logLine
          
      end
    
  end

  # 対戦依頼への応答
  def response_battlereq
  end

  # 対戦ステータス確認
  def battle_status
        # 対戦IDをキーに対戦のステータスを確認
        battle_id = params[:battle_id]
        if (battle_id != nil) then
            battleRecord = BattleRecord.find(:all,  :select => "battle_records.battle_status", :conditions => ["id = ?", battle_id])
            
            # ステータス情報をJSON形式で端末へ返却する
            render :json => battleRecord
        end
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
#  REG_ID = "APA91bHYW76k4HUVUMQM7zqUbbB83ysRzXJkPsh6zn6HlAZm1IBdWKTXHFQEP4u41vu7hdTvfNwTPDvfNaojbGhRFPktf4LTkKg6ciLDSqmMq7isz8QTbCALFAwEjUM8bLghwUotW5rcIvXHd5VogU7OJs7C_AD2-Q"
  # APIキー (Google APIs Consoleで発行されたもの)
  API_KEY = "AIzaSyCDMlzrcinT_WgnDd1frr8O76kTqIGvMmA"

    def send(registrationid)
      
        # 送信するメッセージの内容
        message = {
#          "registration_ids" => [REG_ID],
          "registration_ids" => [registrationid],
          "collapse_key" => "collapse_key",
          "delay_while_idle" => false,
          "time_to_live" => 60,
          "data" => { "message" => "Battle Request",
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
