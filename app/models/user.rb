class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  # :rememberable,

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name
  #, :remember_me


  has_many :presentations
  belongs_to :last_presentation, :class_name => "Presentation", :foreign_key => "last_presentation_id"
  validates_uniqueness_of :email, :name

  def self.next_suggestion
    sorted_list.first
  end

  def self.sorted_list
    without = without_talk.all
    others = sort_users_with_presentation.limit(10).all
    total = []
    total = total + without
    total = total + others
    total
  end

  def self.sort_users_with_presentation
    User.joins(:last_presentation).order('presentations.suggested_date').where('presentations.suggested_date is NOT null')
  end

  def self.without_talk
    User.joins(:presentations).where('presentations.scheduled_date is null').order('presentations.created_at')
  end

end
