require "rails_helper"

RSpec.describe Book, type: :model do
  describe "Associations" do
    it { should belong_to(:author).optional(true) }
    it { should belong_to(:publisher).optional(true) }
    it { should belong_to(:category).optional(true) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:follows) }
    it { should have_many(:users_comments) }
    it { should have_many(:users_likes) }
    it { should have_many(:users_follows) }
  end

  describe "Scopes" do
    let!(:user){FactoryBot.create :user}
    let!(:author){FactoryBot.create :author}
    let!(:publisher){FactoryBot.create :publisher}
    let!(:category){FactoryBot.create :category}
    let!(:book1){FactoryBot.create :book, author_id: author.id,
                                  publisher_id: publisher.id,
                                  category_id: category.id}
    let!(:book2){FactoryBot.create :book, author_id: author.id,
                                  publisher_id: publisher.id,
                                  category_id: category.id}
    it "response to sort by likes count asc" do
      user.like book2
      expect(Book.all.sort_by_likes_count_asc.to_a).to eq([book1, book2])
    end

    it "response to sort by likes count desc" do
      user.like book2
      expect(Book.all.sort_by_likes_count_desc.to_a).to eq([book2, book1])
    end
  end
end
