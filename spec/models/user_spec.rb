require "rails_helper"

RSpec.describe User, type: :model do
  context "email が指定されているとき" do
    fit "user が作成される" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  context "email が指定されていないとき" do
    it "user の作成に失敗する" do
    end
  end

  context "password が指定されているとき" do
    it "user が作成される" do
    end
  end

  context "password が指定されていないとき" do
    it "user の作成に失敗する" do
    end
  end
end
