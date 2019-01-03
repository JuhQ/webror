class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3 }

  validates :username, length: { minimum: 3,
                                 maximum: 30 }

  has_many :ratings # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beerclubs, through: :memberships
end
