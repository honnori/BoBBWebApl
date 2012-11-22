class BobbReqController < ApplicationController
  def regist_user
      name = params['user_name']
      if id != nil then
#          user = User.new
#          user.user_name = name
#          user.save
#          reg_id = params[:registration_id]
#          dev_id = params[:device_id]
          @device = User.create(:user_name => name
#                :registration_id => reg_id,
#               :description => ""
          )
          render :json => @device
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
