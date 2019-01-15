class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3 }

  validates :username, length: { minimum: 3,
                                 maximum: 30 }

  validates :password, length: { minimum: 4 }

  validate :validate_password

  has_many :ratings, dependent: :destroy # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beerclubs, through: :memberships

  def validate_password
    errors.add(:password, "needs to have at least one capital letter") unless password =~ /[A-Z]/
    errors.add(:password, "needs to have at least one number") unless password =~ /[0-9]/
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer.style
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer.brewery
  end
end
