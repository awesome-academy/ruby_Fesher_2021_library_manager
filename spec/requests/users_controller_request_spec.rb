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

  describe "GET #new" do
    it "should render new" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  describe "POST #create" do
    context "when user params valid" do
      let(:user){FactoryBot.attributes_for :user}

      before do
        @mail_count = ActionMailer::Base.deliveries.count
        post :create, params: {locale: I18n.locale, user: user}
      end

      it "should send activation email" do
        expect(ActionMailer::Base.deliveries.count).to eq (@mail_count + 1)
      end

      it "should flash danger " do
        expect(flash[:info]).to eq I18n.t("users.create.please_check_email")
      end

      it "should redirecto root_url" do
        expect(response).to redirect_to root_path
      end
    end

    context "when duplicate email" do
      let!(:user_first){FactoryBot.create :user, email: "example@examplr.erb"}
      let!(:user){FactoryBot.attributes_for :user, email: "example@examplr.erb"}

      before do
        @mail_count = ActionMailer::Base.deliveries.count
        post :create, params: {user: user, id: "something"}
      end

      it "should not send activation email" do
        expect(ActionMailer::Base.deliveries.count).to eq (@mail_count)
      end

      it "should flash danger " do
        expect(flash[:danger]).to eq I18n.t("users.create.fail")
      end

      it "should render new " do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    context "when user not login" do
      let(:user){FactoryBot.create :user}

      before do
        get :edit, params: {locale: I18n.locale, id: user.id}
      end

      it "should redirect to root" do
        expect(response).to redirect_to root_path
      end
    end

    context "when params id invalid" do
      before do
        get :edit, params: {locale: I18n.locale, id: -1}
      end

      it "should redirect to root" do
        expect(response).to redirect_to root_path
      end
    end

    context "when user logged in and corect user" do
      let(:user){FactoryBot.create :user}

      before do
        user.activated = true
        log_in user
        get :edit, params: {locale: I18n.locale, id: user.id}
      end

      it "render edit" do
        expect(response).to render_template(:edit)
      end
    end

    context "when user logged in and not correct user" do
      let!(:user0){FactoryBot.create :user}
      let!(:user){FactoryBot.create :user}

      before do
        user.activated = true
        log_in user
        get :edit, params: {locale: I18n.locale, id: user0.id}
      end

      it "render edit" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #update" do
    context "when user not login" do
      let!(:user){FactoryBot.create :user}
      before do
        post :update, params: {locale: I18n.locale, id: user.id}
      end

      it "should redirect to root" do
        expect(response).to redirect_to root_path
      end
    end

    context "when user logged in and corect user" do
      let!(:user){FactoryBot.create :user}
      let!(:user_params){FactoryBot.attributes_for :user, email: user.email}
      before do
        user.activated = true
        log_in user
        post :update, params: {locale: I18n.locale, user: user_params, id: user.id}
      end

      it "render edit" do
        expect(response).to redirect_to user
      end

      it "flash success" do
        expect(flash[:success]).to eq I18n.t("users.update.success")
      end
    end

    context "when user logged in and not corect user" do
      let!(:user_first){FactoryBot.create :user}
      let!(:user){FactoryBot.create :user}
      let!(:user_params){FactoryBot.attributes_for :user, email: user.email}

      before do
        user.activated = true
        log_in user
        post :update, params: {locale: I18n.locale, user: user_params, id: user_first.id}
      end

      it "render edit" do
        expect(response).to redirect_to root_path
      end
    end

    context "when dupblicate email" do
      let!(:user0){FactoryBot.create :user}
      let!(:user){FactoryBot.create :user}
      let!(:user_params){FactoryBot.attributes_for :user, email: user0.email}

      before do
        user.activated = true
        log_in user
        post :update, params: {locale: I18n.locale, user: user_params, id: user.id}
      end

      it "flash danger" do
        expect(flash[:danger]).to eq I18n.t("users.update.fail")
      end

      it "render edit" do
        expect(response).to render_template(:edit)
      end
    end
  end
end
