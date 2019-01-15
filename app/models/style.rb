class Style < ApplicationRecord
  extend Top
  has_many :beers, dependent: :destroy

  def to_s
    name
  end
end
