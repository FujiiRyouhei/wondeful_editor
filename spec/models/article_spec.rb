require "rails_helper"

RSpec.describe Article, type: :model do
  context "title を指定しているとき" do
    it "article が作られる" do
      article = FactoryBot.build(:article)
      expect(article).to be_valid
    end
  end

  context "title を指定していないとき" do
    it "article が作られない" do
      article = FactoryBot.build(:article, title: nil)
      expect(article).to be_invalid
      expect(article.errors.details[:title][0][:error]).to eq :blank
    end
  end

  context "body を指定していないとき" do
    it "article が作られない" do
      article = FactoryBot.build(:article, body: nil)
      expect(article).to be_invalid
      expect(article.errors.details[:body][0][:error]).to eq :blank
    end
  end
end
