class BattleRecord < ActiveRecord::Base
  attr_accessible :battle_id, :battle_status, :req_user_id, :res_user_id
end
