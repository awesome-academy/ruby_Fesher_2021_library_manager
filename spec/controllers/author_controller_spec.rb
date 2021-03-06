require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
  describe "GET #show" do
    context "when valid params" do
      let!(:author){FactoryBot.create :author}
      let!(:publisher){FactoryBot.create :publisher}
      let!(:category){FactoryBot.create :category}
      before do
        get :show, params: {locale: I18n.locale, id: author.id}
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
end
