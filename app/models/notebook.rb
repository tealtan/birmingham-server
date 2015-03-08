class Notebook < ActiveRecord::Base
  has_and_belongs_to_many :notes

  validates :name, :presence => true
end
