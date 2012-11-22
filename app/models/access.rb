class Access < ActiveRecord::Base
  attr_accessible :access_time, :transaction_id, :user_id, :user_level
end
