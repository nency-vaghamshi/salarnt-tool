require "rails_helper"

RSpec.describe Country, type: :model do
  subject(:country) { build(:country) }

  it "is valid with a name, code, and currency" do
    expect(country).to be_valid
  end

  it "is invalid without a name" do
    country.name = nil

    expect(country).not_to be_valid
    expect(country.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a code" do
    country.code = nil

    expect(country).not_to be_valid
    expect(country.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a currency" do
    country.currency = nil

    expect(country).not_to be_valid
    expect(country.errors[:currency]).to include("must exist")
  end

  it "is invalid with a duplicate code" do
    create(:country, code: "IN")
    duplicate = build(:country, code: "IN")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:code]).to include("has already been taken")
  end
end
