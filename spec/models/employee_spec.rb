require "rails_helper"

RSpec.describe Employee, type: :model do
  subject(:employee) { build(:employee) }

  it "is valid with all required attributes" do
    expect(employee).to be_valid
  end

  it "is invalid without an employee number" do
    employee.employee_number = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:employee_number]).to include("can't be blank")
  end

  it "is invalid with a duplicate employee number" do
    create(:employee, employee_number: "EMP100")
    duplicate = build(:employee, employee_number: "EMP100")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:employee_number]).to include("has already been taken")
  end

  it "is invalid without a first name" do
    employee.first_name = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    employee.last_name = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    employee.email = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email" do
    create(:employee, email: "duplicate@acme.test")
    duplicate = build(:employee, email: "duplicate@acme.test")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a department" do
    employee.department = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:department]).to include("must exist")
  end

  it "is invalid without a job title" do
    employee.job_title = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:job_title]).to include("must exist")
  end

  it "is invalid without a country" do
    employee.country = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:country]).to include("must exist")
  end

  it "is invalid without an employment status" do
    employee.employment_status = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:employment_status]).to include("can't be blank")
  end

  it "is invalid without a joined_on date" do
    employee.joined_on = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:joined_on]).to include("can't be blank")
  end
end
