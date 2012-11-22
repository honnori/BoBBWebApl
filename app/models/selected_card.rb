class SelectedCard < ActiveRecord::Base
  attr_accessible :battle_id, :card_num, :turn_num, :user_id
end
