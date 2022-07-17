require "rails_helper"

RSpec.describe User, type: :model do
  context "email が指定されているとき" do
    it "user が作成される" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  context "email が指定されていないとき" do
    it "user の作成に失敗する" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "password が指定されていないとき" do
    it "user の作成に失敗する" do
      user = FactoryBot.build(:user, password: nil)
      expect(user).to be_invalid
      expect(user.errors.details[:password][0][:error]).to eq :blank
    end
  end
end
