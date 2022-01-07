require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
  end
  describe "Validates" do
    subject{FactoryBot.build(:comment)}
    context "with conntent field " do
      it{should validate_presence_of(:content)}
    end
  end
end
