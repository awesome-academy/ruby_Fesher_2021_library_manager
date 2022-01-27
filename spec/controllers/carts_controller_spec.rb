require "rails_helper"

RSpec.describe CartsController, type: :controller do
  describe "GET #index" do
    it "render show" do
      get :index, params: {locale: I18n.locale}
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    let!(:author){FactoryBot.create :author}
    let!(:publisher){FactoryBot.create :publisher}
    let!(:category){FactoryBot.create :category}
    let!(:book){FactoryBot.create :book, author_id: author.id,
                                publisher_id: publisher.id,
                                category_id: category.id}
    it "add book id to session cart" do
      post :create, params: {locale: I18n.locale, book_id: book.id}, xhr: true
      expect(session[:cart]).to include(book.id)
    end
  end

  describe "Delete #destroy" do
    let!(:author){FactoryBot.create :author}
    let!(:publisher){FactoryBot.create :publisher}
    let!(:category){FactoryBot.create :category}
    let!(:book){FactoryBot.create :book, author_id: author.id,
                                publisher_id: publisher.id,
                                category_id: category.id}
    it "add book id to session cart" do
      session[:cart] ||= []
      session[:cart].push book.id
      delete :destroy, params: {locale: I18n.locale, id: book.id}, xhr: true
      expect(session[:cart]).not_to include(book.id)
    end
  end
end
