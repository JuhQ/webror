class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true

  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }

  validate :validate_year

  def validate_year
    errors.add(:year, "can't be larger than current year") if Time.now.year < year
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def to_s
    name
  end
end
