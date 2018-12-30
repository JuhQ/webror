class Beerclub < ApplicationRecord
  has_many :memberships
  has_many :members, through: :memberships, source: :users
end
