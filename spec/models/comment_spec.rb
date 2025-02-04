require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:user).required }
    it { should belong_to(:lesson).required }
  end

  describe 'scopes' do
    describe '.recent_first' do
      it 'orders comments by created_at in descending order' do
        teacher = create(:user, role: :teacher)
        student = create(:user, role: :student)
        lesson = create(:lesson, teacher: teacher, assigned_to: student)
        older_comment = create(:comment, created_at: 2.days.ago, user: student, lesson: lesson)
        newer_comment = create(:comment, created_at: 1.day.ago, user: student, lesson: lesson)

        expect(described_class.recent_first).to eq([ newer_comment, older_comment ])
      end
    end
  end
end
