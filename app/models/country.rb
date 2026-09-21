class Country < ApplicationRecord
  belongs_to :currency

  has_many :employees
  has_many :tax_configurations

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
