require "rails_helper"
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    context "when not login" do
      let(:user){FactoryBot.create :user}
      let(:author){FactoryBot.create :author}
      let(:publisher){FactoryBot.create :publisher}
      let(:category){FactoryBot.create :category}
      let(:book){FactoryBot.create :book, author_id: author.id,
                                  publisher_id: publisher.id,
                                  category_id: category.id}
      let(:comment){FactoryBot.attributes_for :comment, commentable_id: book.id, commentable_type: "Book"}
      it "redirect to login" do
        post :create, params: {locale: I18n.locale, comment: comment}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when login and valid params" do
      let(:user){FactoryBot.create :user}
      let(:author){FactoryBot.create :author}
      let(:publisher){FactoryBot.create :publisher}
      let(:category){FactoryBot.create :category}
      let(:book){FactoryBot.create :book, author_id: author.id,
                                  publisher_id: publisher.id,
                                  category_id: category.id}
      let(:comment){FactoryBot.attributes_for :comment,
                                              commentable_id: book.id,
                                              commentable_type: "Book"}
      it "redirect to book" do
        sign_in user
        post :create, params: {locale: I18n.locale, comment: comment}
        expect(response).to redirect_to book
      end
    end

    context "when login and valid params" do
      let!(:user){FactoryBot.create :user}
      let!(:author){FactoryBot.create :author}
      let!(:publisher){FactoryBot.create :publisher}
      let!(:category){FactoryBot.create :category}
      let!(:book){FactoryBot.create :book, author_id: author.id,
                                  publisher_id: publisher.id,
                                  category_id: category.id}
      let!(:comment){FactoryBot.attributes_for :comment,
                                              commentable_id: book.id,
                                              commentable_type: "Book",
                                              content: ""}
      before do
        sign_in user
        post :create, params: {locale: I18n.locale, comment: comment}
      end

      it "redirect to book" do
        expect(response).to redirect_to book
      end
    end
  end
end
