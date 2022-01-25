require "rails_helper"

RSpec.describe BooksController, type: :controller do
  describe "GET #show" do
    context "when valid params" do
      let!(:author){FactoryBot.create :author}
      let!(:publisher){FactoryBot.create :publisher}
      let!(:category){FactoryBot.create :category}
      let!(:book){FactoryBot.create :book, author_id: author.id,
                                  publisher_id: publisher.id,
                                  category_id: category.id}
      before do
        get :show, params: {locale: I18n.locale, id: book.id}
      end
      it "render show" do
        expect(response).to render_template(:show)
      end
    end

    context "when invalid params" do
      before do
        get :show, params: {locale: I18n.locale, id: -1}
      end
      it "redirect to root" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #index" do
    it "render index" do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
