class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :user
  belongs_to :link

  attr_accessible :body, :parent_id

  validates :body, :presence => true
  validates :user, :presence => true
  validates :link, :presence => true
end
