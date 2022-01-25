require "rails_helper"

RSpec.describe Admin::AuthorsController, type: :controller do
  let!(:user_admin){FactoryBot.create :user, is_admin: true}
  before do
    sign_in user_admin
  end
  describe "GET #index" do
    it "redner index" do
      get :index, params: {locale: I18n.locale}
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "it render new" do
      get :new, params: {locale: I18n.locale}
      expect(response).to render_template(:new)
    end
  end


  describe "GET #show" do
    let!(:author){FactoryBot.create :author}
    context "when loged in and valid params" do
      it "render show" do
        get :show, params: {locale: I18n.locale, id: author.id}
        expect(response).to render_template(:show)
      end
    end
  end

  describe "POST #create" do
    context "valid params" do
      let(:author){FactoryBot.attributes_for :author}
      before do
        post :create, params: {locale: I18n.locale, author: author}
      end

      it "redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "flash sucess" do
        expect(flash[:success]).to be_present
      end
    end

    context "invalid params" do
      let(:author){FactoryBot.attributes_for :author, name: ""}

      before do
        post :create, params: {locale: I18n.locale, author: author}
      end

      it "render new" do
        expect(response).to render_template(:new)
      end

      it "flash danger" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "POST #update" do
    context "valid params" do
      let(:author){FactoryBot.create :author}
      let(:attribute){FactoryBot.attributes_for :author}
      before do
        post :update, params: {locale: I18n.locale, author: attribute, id: author.id}
      end

      it "flass success" do
        expect(flash[:success]).to be_present
      end

      it "redirect" do
        expect(response).to have_http_status(:redirect)
      end
    end

    context "valid params" do
      let(:author){FactoryBot.create :author}
      let(:attribute){FactoryBot.attributes_for :author, name: ""}
      before do
        post :update, params: {locale: I18n.locale, author: attribute, id: author.id}
      end

      it "flass danger" do
        expect(flash[:danger]).to be_present
      end

      it "render edit" do
        expect(response).to render_template(:edit)
      end
    end

  end


end
