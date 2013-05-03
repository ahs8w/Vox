class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :category, :location, :image, :remote_image_url
  mount_uploader :image, ImageUploader

  default_scope :order => 'updated_at DESC'
  belongs_to :user

  has_many :comments, :order => 'updated_at DESC', :dependent => :destroy
  
  validates :title, :user_id, :category, :location, :presence => true
  validates :content, presence: true,
                      length: { minimum: 2 }
                      
  has_many :ratings, :as => :rateable, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user


  scope :recent, lambda {where("posts.updated_at > ?", 2.days.ago.to_date)}
  scope :search_title, lambda { |term| where("posts.title LIKE ?", "%#{term}%") }

  def average_rating
    if ratings.exists?
      @value = 0
      self.ratings.each do |rating|
        @value = @value + rating.value
      end
      @total = self.ratings.size
      @value.to_f / @total.to_f
    else
      "not yet rated"
    end
  end

  def long_title
    "#{title} - #{updated_at}"
  end
end
