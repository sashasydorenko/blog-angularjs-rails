class Post < ActiveRecord::Base
  attr_accessible :title, :desc, :body
  validates :title, presence: true
  validates :desc, presence: true
end
