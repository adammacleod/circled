class Link < ActiveRecord::Base
  attr_accessible :body, :link, :slug, :title

  validates :link,  :presence => true
  validates :slug,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
end
