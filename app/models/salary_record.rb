class SalaryRecord < ApplicationRecord
  belongs_to :employee
  belongs_to :currency

  validates :effective_from, presence: true
  validates :status, presence: true

  validate :effective_to_on_or_after_effective_from
  validate :effective_period_does_not_overlap_existing_records

  private

  def effective_to_on_or_after_effective_from
    return if effective_from.blank? || effective_to.blank?

    errors.add(:effective_to, "must be on or after the effective_from date") if effective_to < effective_from
  end

  # Business rule: an employee's salary periods must not overlap (see acme_salary_management_database_design.md, section 9).
  def effective_period_does_not_overlap_existing_records
    return if employee.blank? || effective_from.blank?

    candidates = employee.salary_records.where.not(id: id)
    candidates = candidates.where("effective_to IS NULL OR effective_to >= ?", effective_from)
    candidates = candidates.where("effective_from <= ?", effective_to) if effective_to.present?

    errors.add(:effective_from, "overlaps an existing salary record for this employee") if candidates.exists?
  end
end
