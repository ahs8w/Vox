class Comment < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :category, :location, :post_id

  belongs_to :post
  belongs_to :user

  validates :title, :category, :location, :user_id, :post_id, :presence => true
  validates :content, presence: true,
                      length: { minimum: 2 }

  has_many :ratings, :as => :rateable, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user


  scope :recent, lambda { where("comments.updated_at > ?", 2.days.ago.to_date) }
  scope :search_title, lambda { |term| where("comments.title LIKE ?", "%#{term}%") }

end