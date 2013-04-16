class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name
  
  has_many :posts, :order => 'updated_at DESC', :dependent => :nullify

  has_many :comments, :order => 'updated_at DESC', :dependent => :destroy
  has_many :responses, :through => :posts, :source => :comments
  
  has_many :ratings, :dependent => :destroy
  has_many :rated_comments, :through => :ratings, :source => :rateable, :source_type => 'Comment'
  has_many :rated_posts, :through => :ratings, :source => :rateable, :source_type => 'Post'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, 
                           uniqueness: true,
                           format: {
                           with: /^[a-zA-Z0-9_-]+$/,
                           message: "Must be formatted correctly."                    
                           }
  
  has_many :images
  
  def full_name
    first_name + " " + last_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  end

  def user_rating
    value = 0
    count = 0
    self.posts.each do |post|
      if post.ratings.exists? 
        value += post.average_rating
        count += 1
      end
    end
    self.comments.each do |comment|
      if comment.ratings.exists?
        value += comment.average_rating
        count += 1
      end
    end
    
    if count == 0
      "no rated articles"
    else
      (value / count).round(2)
    end
  end
end
