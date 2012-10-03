class User < ActiveRecord::Base
  # TODO: http://guides.rubyonrails.org/security.html

  # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  has_secure_password

  attr_accessible :username,
                  :password,
                  :password_confirmation

  validates :password_digest, :presence => true
  validates :username, :presence => true,
                       :length => { :minimum => 3 },
                       :uniqueness => true

  def to_param
    username
  end
end
