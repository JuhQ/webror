class Style < ApplicationRecord
  has_many :beers, dependent: :destroy

  def to_s
    name
  end

  def self.top(how_many)
    sorted_by_rating_in_desc_order = all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order[0, how_many]
  end
end
