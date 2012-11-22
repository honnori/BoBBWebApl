class CreateUsingCards < ActiveRecord::Migration
  def change
    create_table :using_cards do |t|
      t.integer :battle_id
      t.integer :user_id
      t.integer :card_num
      t.integer :beetlekit_id
      t.text :image_id
      t.text :image_file_name
      t.text :beetle_name
      t.integer :type
      t.text :intro
      t.integer :attack
      t.integer :defense
      t.integer :attribute
      t.text :effect
      t.integer :effect_id

      t.timestamps
    end
  end
end
