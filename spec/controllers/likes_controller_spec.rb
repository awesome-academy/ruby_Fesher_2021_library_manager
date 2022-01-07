require "rails_helper"
include SessionsHelper
include LikesHelper

RSpec.describe LikesController, type: :controller do
  describe "POST #create" do
    let(:user){FactoryBot.create :user}
    let(:author){FactoryBot.create :author}
    let(:publisher){FactoryBot.create :publisher}
    let(:category){FactoryBot.create :category}
    let(:book){FactoryBot.create :book, author_id: author.id,
                                publisher_id: publisher.id,
                                category_id: category.id}
    context "when not login" do
      it "redirect to login" do
        post :create, params: {locale: I18n.locale, likeable_id: book.id, likeable_type: "Book"}
        expect(response).to redirect_to login_path
      end
    end

    context "when login like book" do
      it "redirect to book" do
        log_in user
        post :create, params: {locale: I18n.locale, likeable_id: book.id, likeable_type: "Book"}
        expect(response).to redirect_to book
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user){FactoryBot.create :user}
    let(:author){FactoryBot.create :author}
    let(:publisher){FactoryBot.create :publisher}
    let(:category){FactoryBot.create :category}
    let(:book){FactoryBot.create :book, author_id: author.id,
                                publisher_id: publisher.id,
                                category_id: category.id}
    before(:each) do
      user.like book
      log_in user
      @like = get_likes(book)
    end

    context "when not login" do
      it "redirect to login" do
        log_out
        delete :destroy, params: {locale: I18n.locale, id: @like.id}
        expect(response).to redirect_to login_path
      end
    end

    context "when login" do
      it "redirect to book" do
        delete :destroy, params: {locale: I18n.locale, id: @like.id}
        expect(response).to redirect_to book
      end
    end
  end
end