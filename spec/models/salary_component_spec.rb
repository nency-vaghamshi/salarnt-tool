require "rails_helper"

RSpec.describe SalaryComponent, type: :model do
  subject(:salary_component) { build(:salary_component) }

  it "is valid with a name, code, component_type, and calculation_type" do
    expect(salary_component).to be_valid
  end

  it "is invalid without a name" do
    salary_component.name = nil

    expect(salary_component).not_to be_valid
    expect(salary_component.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a code" do
    salary_component.code = nil

    expect(salary_component).not_to be_valid
    expect(salary_component.errors[:code]).to include("can't be blank")
  end

  it "is invalid with a duplicate code" do
    create(:salary_component, code: "BASIC")
    duplicate = build(:salary_component, code: "BASIC")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:code]).to include("has already been taken")
  end

  it "is invalid with a component_type outside earning/deduction" do
    salary_component.component_type = "bonus"

    expect(salary_component).not_to be_valid
    expect(salary_component.errors[:component_type]).to include("is not included in the list")
  end

  it "is invalid with a calculation_type outside fixed/percentage/calculated" do
    salary_component.calculation_type = "manual"

    expect(salary_component).not_to be_valid
    expect(salary_component.errors[:calculation_type]).to include("is not included in the list")
  end

  it "is invalid without a component_type" do
    salary_component.component_type = nil

    expect(salary_component).not_to be_valid
    expect(salary_component.errors[:component_type]).to include("can't be blank")
  end

  it "is invalid without a calculation_type" do
    salary_component.calculation_type = nil

    expect(salary_component).not_to be_valid
    expect(salary_component.errors[:calculation_type]).to include("can't be blank")
  end
end
