class Rating < ActiveRecord::Base
  attr_accessible :value, :user_id, :rateable_id, :rateable_type

  validates_presence_of :user_id, :rateable_id, :value, :rateable_type
  
  belongs_to :rateable, :polymorphic => true
  belongs_to :user

end
