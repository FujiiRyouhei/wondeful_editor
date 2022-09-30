require "rails_helper"

RSpec.describe "Api/V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth/registrations" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "正しいパラメーターを送信したとき" do
      let(:params) { attributes_for(:user) }

      it "新規ユーザーが登録される" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        res = JSON.parse(response.body)
        expect(res["data"]["email"]).to eq(User.last.email)
      end

      it "header 情報が取得できる" do
        subject
        res = response.header
        expect(res.has_key?("access-token")).to eq true
        expect(res.has_key?("token-type")).to eq true
        expect(res.has_key?("client")).to eq true
        expect(res.has_key?("expiry")).to eq true
        expect(res.has_key?("uid")).to eq true
      end
    end

    context "誤ったパラメータを送信したとき" do
      context "email がなかった時" do
        let(:params) { attributes_for(:user, email: nil) }

        it "エラーが生じる" do
          # binding.pry
          subject
          res = JSON.parse(response.body)
          expect { subject }.to change { User.count }.by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res["errors"]["email"]).to include "can't be blank"
        end
      end

      context "password がなかった時" do
        let(:params) { attributes_for(:user, password: nil) }

        it "エラーが生じる" do
          subject
          res = JSON.parse(response.body)
          expect { subject }.to change { User.count }.by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res["errors"]["password"]).to include "can't be blank"
        end
      end
    end
  end
end
