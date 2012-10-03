class Link < ActiveRecord::Base
  attr_accessible :body, :link, :slug, :title

  validates :link,  :presence => true
  validates :slug,  :presence => true,
                    :uniqueness => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }

  before_validation do
    self.slug = title.parameterize
  end

  def to_param
    slug
  end
end
