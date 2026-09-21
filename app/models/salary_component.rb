class SalaryComponent < ApplicationRecord
  COMPONENT_TYPES = %w[earning deduction].freeze
  CALCULATION_TYPES = %w[fixed percentage calculated].freeze

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :component_type, presence: true, inclusion: { in: COMPONENT_TYPES }
  validates :calculation_type, presence: true, inclusion: { in: CALCULATION_TYPES }
end
