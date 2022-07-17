require "rails_helper"

RSpec.describe Comment, type: :model do
  context "body を指定しているとき" do
    it "comment が作られる" do
      comment = FactoryBot.build(:comment)
      binding.pry
      expect(comment).to be_valid
    end
  end

  context "body を指定していないとき" do
    it "comment が作られる" do
    end
  end
end
