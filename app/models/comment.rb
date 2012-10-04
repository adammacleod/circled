class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  belongs_to :comment
  has_many :comments

  attr_accessible :body

  validates :body, :presence => true
  validates :user, :presence => true
  validates :link, :presence => true
end
