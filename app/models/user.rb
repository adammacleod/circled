class User < ActiveRecord::Base
  attr_accessible :password, :username

  validates :password, :presence => true
  validates :username, :presence => true,
                       :length => { :minimum => 3 },
                       :uniqueness => true

  def to_param
    username
  end
end
