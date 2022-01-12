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
      it{should validate_presence_of(:address)}
      it{should validate_length_of(:address).is_at_least(Settings.length.password_min)}
    end

    context "with phone field" do
      it{should validate_presence_of(:phone)}
      it{should allow_value("0393203261").for(:phone)}
      it{should_not allow_value("020220").for(:phone)}
    end

    context "with password field" do
      it{should validate_length_of(:password).is_at_least(Settings.length.password_min)}
      it{should validate_confirmation_of(:password)}
    end
  end

  describe "#is_admin?" do
    let(:user){FactoryBot.create :user}
    it "return true when user is admin" do
      user.is_admin = true
      expect(user.is_admin?).to eq true
    end
    it "return false when user is not admin" do
      expect(user.is_admin?).to eq false
    end
  end

  describe ".activate" do
    let(:user){FactoryBot.create :user}
    it "activated should equal to true" do
      expect{user.activate} .to change{user.activated}
    end
  end

  describe "#authenticated?" do
    let(:user){FactoryBot.create :user}
    it "should returns true when correct passowrd" do
      expect(user.authenticated?(:password, "password!@#")).to eq true
    end

    it "should returns false when incorrect passowrd" do
      expect(user.authenticated?(:password, "password!@1#")).to eq false
    end

    it "should returns false when user digest = nil" do
      expect(user.authenticated?(:activation, "password!@1#")).to eq false
    end
  end

  describe ".send_password_reset_email" do
    let(:user){FactoryBot.create :user}
    it "should sends reset email" do
      user.create_reset_digest
      expect (user.send_password_reset_email).to change {ActionMailer::Base.deliveries.count}.by(1)
    end
  end

  describe ".send_activation_email" do
    let(:user){FactoryBot.create :user}
    it "should sends activation email" do
      expect (user.send_activation_email).to change {ActionMailer::Base.deliveries.count}.by(1)
    end
  end

  describe ".create_reset_digest" do
    let(:user){FactoryBot.create :user}
    it "creates new reset token" do
      expect{user.create_reset_digest}
        .to change{user.reset_digest}
    end
  end

  describe "#password_reset_expired?" do
    let(:user){FactoryBot.create :user}
    it "returns true when reset_send_at before now more than 2 hours" do
      user.reset_sent_at = Time.zone.now - 3.hour
      expect(user.password_reset_expired?).to eq true
    end

    it "returns false when reset_send_at before now less than 2 hours" do
      user.reset_sent_at = Time.zone.now - 1.hour
      expect(user.password_reset_expired?).to eq false
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

  describe ".new_token" do
    it "returns a new token" do
      expect User.new_token != nil
    end
  end

  describe ".digest" do
    it "return passord diget" do
      ActiveModel::SecurePassword.min_cost = false
      expect User.digest("password") != nil
    end

    it "return passord diget with min_cost" do
      ActiveModel::SecurePassword.min_cost = true
      expect User.digest("password") != nil
    end
  end
end
