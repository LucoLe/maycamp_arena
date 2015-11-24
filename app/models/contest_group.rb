class ContestGroup < ActiveRecord::Base
  has_many :contests

  validates_presence_of :name
  validates_uniqueness_of :name
end
