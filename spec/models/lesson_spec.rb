require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:teacher).class_name('User').required }
    it { should belong_to(:assigned_to).class_name('User').required }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'scopes' do
    describe '.recent_first' do
      it 'orders lessons by created_at in descending order' do
        teacher = create(:user, role: :teacher)
        student = create(:user, role: :student)
        older_lesson = create(:lesson, created_at: 2.days.ago, teacher: teacher, assigned_to: student)
        newer_lesson = create(:lesson, created_at: 1.day.ago, teacher: teacher, assigned_to: student)

        expect(described_class.recent_first).to eq([newer_lesson, older_lesson])
      end
    end
  end
end 