class BobbReqController < ApplicationController

  # ユーザ名登録
  def regist_user
      name = params[:user_name]
      if name != nil then
          # DBにユーザ名をインサートして、インサートしたレコードを取得
          device = User.create(:user_name => name)
          
          # 登録した情報を全てJSON形式で端末へ返却する
          render :json => device
      end
      
  end

  def access_log
  end

  def online_user_list
  end

  def request_battle
  end

  def response_battlereq
  end

  def battle_status
  end

  def enemy_using_card
  end

  def regist_using_card
  end

  def regist_selected_card
  end

  def enemy_selected_card
  end

  def battle_stop
  end
end
