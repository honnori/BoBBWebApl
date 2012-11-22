class CreateBattleRecords < ActiveRecord::Migration
  def change
    create_table :battle_records do |t|
#      t.primary_key :battle_id
      t.integer :req_user_id
      t.integer :res_user_id
      t.integer :battle_status

      t.timestamps
    end
  end
end
