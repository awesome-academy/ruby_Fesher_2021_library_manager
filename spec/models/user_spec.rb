require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it{should have_many(:requests).dependent(:destroy)}
    it{should have_many(:follow_books).dependent(:destroy)}
    it{should have_many(:follow_users).dependent(:destroy)}
    it{should have_many(:follow_authors).dependent(:destroy)}
    it{should have_many(:comment_books_relationship).dependent(:destroy)}
    it{should have_many(:cmt_authors_relationship).dependent(:destroy)}
    it{should have_many(:like_books_relationship).dependent(:destroy)}
    it{should have_many(:like_authors_relationship).dependent(:destroy)}
    it{should have_many(:following_books)}
    it{should have_many(:following_authors)}
    it{should have_many(:following_users)}
    it{should have_many(:comment_books)}
    it{should have_many(:comment_authors)}
    it{should have_many(:like_books)}
    it{should have_many(:like_authors)}
    it{should have_many(:passive_follows).dependent(:destroy)}
    it{should have_many(:followers)}
  end

  describe "Validates" do
    subject{FactoryBot.build(:user)}
    context "with name field " do
      it{should validate_presence_of(:name)}
      it{should validate_length_of(:name)
        .is_at_most(Settings.length.user_name_max)}
    end

    context "with email field" do
      it{should validate_presence_of(:email)}
      it{
        should validate_length_of(:email)
          .is_at_most(Settings.length.email_max)}
      it{should validate_uniqueness_of(:email).case_insensitive}
      it{should allow_value("a@b.c").for(:email)}
      it{should_not allow_value("s").for(:email)}
    end

    context "with address field" do
      it{should allow_value(nil).for(:address)}
      it{should validate_length_of(:address).is_at_least(Settings.length.password_min)}
      it{should_not allow_value("").for(:address)}
    end

    context "with phone field" do
      it{should allow_value("0393203261",nil).for(:phone)}
      it{should_not allow_value("020220","").for(:phone)}
    end

    context "with password field" do
      it{should validate_length_of(:password).is_at_least(Settings.length.password_min)}
      it{should validate_confirmation_of(:password)}
    end
  end

  describe ".liked?" do
    let(:user){FactoryBot.create :user}
    let(:author){FactoryBot.create :author}
    let(:publisher){FactoryBot.create :publisher}
    let(:category){FactoryBot.create :category}
    let(:book){FactoryBot.create :book, author_id: author.id,
                                publisher_id: publisher.id,
                                category_id: category.id}
    context "when user liked book" do
      it "return true" do
        user.like book
        expect(user.liked? book).to eq true
      end
    end

    context "when user liked book" do
      it "return true" do
        expect(user.liked? book).to eq false
      end
    end

  end

  describe ".downcase_email" do
    context "when email has upcase" do
      let(:user){FactoryBot.create :user, email: "ABC@gmail.com"}
      it "should change email to downcase" do
        user.save
        expect(user.email).to eq "abc@gmail.com"
      end
    end

    context "when email doesn't has upcase" do
      let(:user){FactoryBot.create :user, email: "abc@gmail.com"}
      it "should not change email" do
        user.save
        expect(user.email).to eq "abc@gmail.com"
      end
    end
  end
end
