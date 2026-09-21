require "rails_helper"

RSpec.describe SalaryRecord, type: :model do
  subject(:salary_record) { build(:salary_record) }

  it "is valid with an employee, currency, effective_from, and status" do
    expect(salary_record).to be_valid
  end

  it "is invalid without an employee" do
    salary_record.employee = nil

    expect(salary_record).not_to be_valid
    expect(salary_record.errors[:employee]).to include("must exist")
  end

  it "is invalid without a currency" do
    salary_record.currency = nil

    expect(salary_record).not_to be_valid
    expect(salary_record.errors[:currency]).to include("must exist")
  end

  it "is invalid without an effective_from date" do
    salary_record.effective_from = nil

    expect(salary_record).not_to be_valid
    expect(salary_record.errors[:effective_from]).to include("can't be blank")
  end

  it "is invalid without a status" do
    salary_record.status = nil

    expect(salary_record).not_to be_valid
    expect(salary_record.errors[:status]).to include("can't be blank")
  end

  it "is invalid when effective_to is before effective_from" do
    salary_record.effective_from = Date.new(2025, 4, 1)
    salary_record.effective_to = Date.new(2025, 3, 31)

    expect(salary_record).not_to be_valid
    expect(salary_record.errors[:effective_to]).to include("must be on or after the effective_from date")
  end

  it "is valid with a nil effective_to representing an open-ended record" do
    salary_record.effective_to = nil

    expect(salary_record).to be_valid
  end

  it "is invalid when its period overlaps an existing salary record for the same employee" do
    employee = create(:employee)
    create(:salary_record, employee: employee, effective_from: Date.new(2024, 4, 1), effective_to: Date.new(2025, 3, 31))
    overlapping = build(:salary_record, employee: employee, effective_from: Date.new(2025, 1, 1), effective_to: Date.new(2025, 12, 31))

    expect(overlapping).not_to be_valid
    expect(overlapping.errors[:effective_from]).to include("overlaps an existing salary record for this employee")
  end

  it "is invalid when an open-ended period overlaps an existing open-ended record for the same employee" do
    employee = create(:employee)
    create(:salary_record, employee: employee, effective_from: Date.new(2024, 4, 1), effective_to: nil)
    overlapping = build(:salary_record, employee: employee, effective_from: Date.new(2025, 4, 1), effective_to: nil)

    expect(overlapping).not_to be_valid
    expect(overlapping.errors[:effective_from]).to include("overlaps an existing salary record for this employee")
  end

  it "is valid when its period follows an existing salary record without overlapping" do
    employee = create(:employee)
    create(:salary_record, employee: employee, effective_from: Date.new(2024, 4, 1), effective_to: Date.new(2025, 3, 31))
    non_overlapping = build(:salary_record, employee: employee, effective_from: Date.new(2025, 4, 1), effective_to: Date.new(2026, 3, 31))

    expect(non_overlapping).to be_valid
  end

  it "is valid when updating a salary record without comparing it against itself" do
    salary_record.save!

    expect(salary_record).to be_valid
  end
end
