require "rails_helper"

RSpec.describe "Api/V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "email と password が一致した時" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: user.email, password: user.password) }

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
      let(:params) { attributes_for(:user, email: "hoge", password: user.password) }

      it "ログインに失敗する" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["uid"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "passwordが一致しない時" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: user.email, password: "hoge") }

      it "ログインに失敗する" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["uid"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, params: params) }

    context "uid,access-token,clientが一致したとき" do
      let(:user) { create(:user) }
      let!(:params) { user.create_new_auth_token }

      it "ログアウトできる" do
        expect { subject }.to change { user.reload.tokens }.from(be_present).to(be_blank)
        expect(response).to have_http_status(:ok)
        header = response.header
        expect(header["uid"]).to be_blank
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["token-type"]).to be_blank
        expect(header["expity"]).to be_blank
      end
    end

    context "入力内容に誤りがある時" do
      let(:user) { create(:user) }
      let(:params) { { "uid": "", "access-token": "", "client": "", "token-type": "", "expity": "" } }

      it "ログアウトに失敗する" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "User was not found or was not logged in."
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
