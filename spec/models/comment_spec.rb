require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:lesson) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:lesson) }
  end

  describe 'scopes' do
    describe '.recent_first' do
      let!(:older_comment) { create(:comment, created_at: 2.days.ago) }
      let!(:newer_comment) { create(:comment, created_at: 1.day.ago) }

      it 'orders comments by created_at in descending order' do
        expect(described_class.recent_first).to eq([newer_comment, older_comment])
      end
    end
  end
end 