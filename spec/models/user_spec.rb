require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }
  end

  describe 'associations' do
    it { should have_many(:taught_lessons).class_name('Lesson').with_foreign_key('teacher_id') }
    it { should have_many(:assigned_lessons).class_name('Lesson').with_foreign_key('assigned_to_id') }
    it { should have_many(:comments) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(student: 0, teacher: 1) }
  end

  describe 'methods' do
    let(:user) { create(:user) }

    describe '#teacher?' do
      context 'when user is a teacher' do
        let(:user) { create(:user, role: :teacher) }
        it 'returns true' do
          expect(user.teacher?).to be true
        end
      end

      context 'when user is a student' do
        let(:user) { create(:user, role: :student) }
        it 'returns false' do
          expect(user.teacher?).to be false
        end
      end
    end

    describe '#student?' do
      context 'when user is a student' do
        let(:user) { create(:user, role: :student) }
        it 'returns true' do
          expect(user.student?).to be true
        end
      end

      context 'when user is a teacher' do
        let(:user) { create(:user, role: :teacher) }
        it 'returns false' do
          expect(user.student?).to be false
        end
      end
    end
  end
end 