class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :user_id
      t.integer :user_level
      t.timestamp :access_time
      t.text :transaction_id

      t.timestamps
    end
  end
end
