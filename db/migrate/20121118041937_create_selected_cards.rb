class CreateSelectedCards < ActiveRecord::Migration
  def change
    create_table :selected_cards do |t|
      t.integer :battle_id
      t.integer :user_id
      t.integer :turn_num
      t.integer :card_num

      t.timestamps
    end
  end
end
