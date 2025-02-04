class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Constants
  ROLES = %w[student teacher].freeze

  # Scopes
  scope :student, -> { where(role: 'student') }
  scope :teacher, -> { where(role: 'teacher') }

  # Associations
  has_many :taught_lessons, class_name: 'Lesson', foreign_key: 'teacher_id', dependent: :destroy
  has_many :assigned_lessons, class_name: 'Lesson', foreign_key: 'assigned_to_id'
  has_many :comments, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :points, numericality: { greater_than_or_equal_to: 0 }

  # Callbacks
  before_validation :set_default_points, on: :create

  # Methods
  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end

  def increment_points!(amount = 1)
    with_lock do
      increment!(:points, amount)
    end
  end

  private

  def set_default_points
    self.points ||= 0
  end
end 