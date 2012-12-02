# coding: utf-8

class BobbReqController < ApplicationController
  
  require 'json'
  
  def index
        @users = User.all
        @accessList = Access.all
        @BattleRecords = BattleRecord.all
        @cards = Battleusingcard.all
        @selectedCards = SelectedCard.all
        
  end

  # ユーザ名登録
  def regist_user
      name = params[:user_name]
      if name != nil then
        
        userLine = User.all
          # DBにユーザ名をインサートして、インサートしたレコードを取得
          userLine = User.create(:user_name => name)
          
          # 登録した情報を全てJSON形式で端末へ返却する
          
#          jsonNanalyzed = ActiveSupport::JSON.encode(userLine)
#          render :text => jsonNanalyzed
          render :json => userLine
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
    
    user_id = params[:user_id]
    level = params[:user_level]
    
    #アクセスログのうち、15分以内の条件で引っ張る
    time = Time.now
    accesslogs = Access.find(:all, :conditions => [" access_time >= '#{time - (60 * 15)}'"])
    
    #将来的にはLVでも絞れるようにしたい
    
    
    #ユーザIDをキーに対戦要求が出されていて、対戦ステータスが"0"のものを一覧に追加する。その際、対戦IDの項目も付加する。
    responselist = Array.new
    useridlist = Array.new
    
    status = 0
    battleRecord = BattleRecord.find(:all, \
                      :select => ["battle_records.req_user_id", "battle_records.id"], \
                      :conditions => ["res_user_id = ? and battle_status = ?", user_id, status])
                      
    
    battleRecord.each do |record|
        # アクセスログから、本リクエストをかけたユーザに対戦要求をしているユーザの最新のアクセスログを取得する
        user_access_info = Access.find(:last, :conditions => ["id = ?", record.req_user_id])
      
        response = {
          "user_id" => user_access_info.user_id,
          "user_name" => user_access_info.user_name,
          "user_level" => user_access_info.user_level,
          "transaction_id" => user_access_info.transaction_id,
          "battle_id" => record.id
        }
        useridlist.push(user_access_info.user_id)
        responselist.push(response)
    end
    
    
    # 既出のレコードを追加
    accesslogs.each do |accesslog|
      
      # 既に追加しているIDと一致しなければ追加する
      if (! useridlist.include?(accesslog.user_id))
        # アクセスログに対戦ID=0を付加
        response = {
          "user_id" => accesslog.user_id,
          "user_name" => accesslog.user_name,
          "user_level" => accesslog.user_level,
          "transaction_id" => accesslog.transaction_id,
          "battle_id" => 0
        }
        responselist.push(response)
      end

    end
    
    # ユーザIDをキーに
    
    
    # 条件検索で取得した情報を全てJSON形式で端末へ返却する
    render :json => responselist
    
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
      battle_id = params[:battle_id]
      
      if (battle_id != nil) then
          # ステータスを0に設定　依頼中(0)、開始(1)、拒否(2)、終了(3)
          record = BattleRecord.where(:id => battle_id).first
          record.update_attributes( :battle_status => "1" )
          render :json => record
      end

  end

  # 対戦ステータス確認
  def battle_status
        # 対戦IDをキーに対戦のステータスを確認
        battle_id = params[:battle_id]
        if (battle_id != nil) then
            battleRecord = BattleRecord.find(:first, :select => ["battle_records.battle_status", "battle_records.id"], :conditions => ["id = ?", battle_id])
             
            # ステータス情報をJSON形式で端末へ返却する
            render :json => battleRecord
        end
  end

  # 対戦相手カード情報取得要求
  def enemy_using_card
        battle_id = params[:battle_id]
        user_id = params[:user_id]

        cards = Battleusingcard.find(:all, :conditions => ["battle_id = ? and user_id = ?", battle_id, user_id])

        render :json => cards
    
  end

  # 対戦使用カード情報登録
  def regist_using_card
    
      battle_id = params[:battle_id]
      user_id = params[:user_id]
      beetel_card_infolist = params[:beetel_card_infolist]
      jsonNanalyzed = ActiveSupport::JSON.decode(beetel_card_infolist)
      
      jsonNanalyzed.each do |record|
          # 使用カード情報テーブルにデータインサート
          cards = Battleusingcard.create(
            :battle_id => battle_id,
            :user_id => user_id,
            :card_num => record.fetch("card_num"),
            :beetlekit_id => record.fetch("beetlekit_id"),
            :image_id => record.fetch("image_id"),
            :image_file_name => record.fetch("image_file_name"),
            :beetle_name => record.fetch("beetle_name"),
            :cardtype => record.fetch("cardtype"),
            :intro => record.fetch("intro"),
            :attack => record.fetch("attack"),
            :defense => record.fetch("defense"),
            :cardattr => record.fetch("cardattr"),
            :effect => record.fetch("effect"),
            :effect_id => record.fetch("effect_id"))
      end
      
      render :json => jsonNanalyzed
    
  end

  # 対戦時選択カード情報登録
  def regist_selected_card
  end

  # 対戦時選択カード情報取得
  def enemy_selected_card
  end

  # 対戦終了/中断通知
  def battle_stop
      battle_id = params[:battle_id]
      status = params[:status]
      
      if (battle_id != nil) then
          # ステータスを0に設定　依頼中(0)、開始(1)、拒否(2)、終了(3)
          record = BattleRecord.where(:id => battle_id).first
          record.update_attributes( :battle_status => status )
          render :json => record
      end

  end
  
  # レコード削除
  def delete
        User.delete_all
        Access.delete_all
        BattleRecord.delete_all
        Battleusingcard.delete_all
        SelectedCard.delete_all

        render :json => "delete finish"

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
