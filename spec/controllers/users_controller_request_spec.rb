require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    context "when params id valid" do
      let(:user) {FactoryBot.create :user}

      before do
        get :show, params: {locale: I18n.locale, id: user.id}
      end

      it "render show" do
        expect(response).to render_template(:show)
      end
    end

    context "when params id invalid" do
      it "should redirect to root" do
        get :show, params: {locale: I18n.locale, id: -1}
        expect(response).to redirect_to root_path
      end
    end
  end
end
