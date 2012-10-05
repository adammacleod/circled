class Link < ActiveRecord::Base
  attr_accessible :body, :link, :slug, :title, :score

  belongs_to :user
  has_many :comments

  validates :link,  :presence => true
  validates :slug,  :presence => true,
                    :uniqueness => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
  validates :user,  :presence => true

  before_validation do
    self.slug = title.parameterize

    # Check that links begin with http
    unless self.link =~ %r!^https?://!
      self.link = "http://#{self.link}"
    end
  end

  def to_param
    slug
  end
end
