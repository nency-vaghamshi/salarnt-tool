require "rails_helper"

RSpec.describe JobTitle, type: :model do
  subject(:job_title) { build(:job_title) }

  it "is valid with a name and code" do
    expect(job_title).to be_valid
  end

  it "is invalid without a name" do
    job_title.name = nil

    expect(job_title).not_to be_valid
    expect(job_title.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a code" do
    job_title.code = nil

    expect(job_title).not_to be_valid
    expect(job_title.errors[:code]).to include("can't be blank")
  end

  it "is invalid with a duplicate code" do
    create(:job_title, code: "SWE")
    duplicate = build(:job_title, code: "SWE")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:code]).to include("has already been taken")
  end
end
