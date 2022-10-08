require "rails_helper"

RSpec.describe "Api/V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "email と password が一致した時" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email:user.email, password:user.password) }

      it "ログインできる" do
        subject
        header = response.header
        expect(header["uid"]).to be_present
        expect(header["client"]).to be_present
        expect(header["access-token"]).to be_present
        expect(response).to have_http_status(:ok)

      end
    end

    context "emailが一致しない時" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email:"hoge", password:user.password) }

      it "ログインに失敗する" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["uid"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(response).to have_http_status(401)

      end
    end

    context "passwordが一致しない時" do
      let(:user) { create(:user) }
      let(:params) {attributes_for(:user, email:user.email, password:"hoge")}

      it "ログインに失敗する" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["uid"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(response).to have_http_status(401)
      end

    end

  end
end
