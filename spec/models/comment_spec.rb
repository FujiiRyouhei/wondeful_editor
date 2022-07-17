require "rails_helper"

RSpec.describe Comment, type: :model do
  context "body を指定しているとき" do
    it "comment が作られる" do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end
  end

  context "body を指定していないとき" do
    it "comment の作成に失敗する" do
      comment = FactoryBot.build(:comment, body: nil)
      expect(comment).to be_invalid
      expect(comment.errors.details[:body][0][:error]).to eq :blank
    end
  end
end
