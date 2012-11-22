class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.primary_key :user_id

      t.timestamps
    end
  end
end
