class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    avg = 0
    for rating in ratings do
      avg += rating.score
    end
    avg / ratings.count
  end

end
