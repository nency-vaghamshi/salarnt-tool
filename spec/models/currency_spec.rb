require "rails_helper"

RSpec.describe Currency, type: :model do
  subject(:currency) { build(:currency) }

  it "is valid with a code, name, and symbol" do
    expect(currency).to be_valid
  end

  it "is invalid without a code" do
    currency.code = nil

    expect(currency).not_to be_valid
    expect(currency.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a name" do
    currency.name = nil

    expect(currency).not_to be_valid
    expect(currency.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a symbol" do
    currency.symbol = nil

    expect(currency).not_to be_valid
    expect(currency.errors[:symbol]).to include("can't be blank")
  end

  it "is invalid with a duplicate code" do
    create(:currency, code: "INR")
    duplicate = build(:currency, code: "INR")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:code]).to include("has already been taken")
  end
end
