class Battleusingcard < ActiveRecord::Base
  attr_accessible :attack, :battle_id, :beetle_name, :beetlekit_id, :card_num, :cardattr, :cardtype, :defense, :effect, :effect_id, :image_file_name, :image_id, :intro, :user_id
end
