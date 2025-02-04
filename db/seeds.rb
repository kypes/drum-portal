# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create users first
puts "Creating users..."
teacher = User.find_or_create_by!(email: 'teacher@example.com') do |user|
  user.name = 'John Smith'
  user.password = 'password123'
  user.role = 'teacher'
end
puts "Teacher created successfully"

student = User.find_or_create_by!(email: 'student@example.com') do |user|
  user.name = 'Jane Doe'
  user.password = 'password123'
  user.role = 'student'
end
puts "Student created successfully"

# Verify roles
puts "Verifying roles..."
puts "Teacher role: #{teacher.role}, Is teacher? #{teacher.teacher?}"
puts "Student role: #{student.role}, Is student? #{student.student?}"

# Create lesson
puts "Creating lesson..."
lesson = Lesson.find_or_create_by!(title: 'Basic Drum Beats') do |l|
  l.content = '# Introduction to Basic Beats

Here are some fundamental drum patterns every beginner should know:

1. The Basic Rock Beat
2. The Simple 8th Note Pattern
3. The Basic Jazz Ride Pattern

Watch the video below for a demonstration.'
  l.teacher = teacher
  l.assigned_to = student
  l.youtube_url = 'https://www.youtube.com/watch?v=example'
end
puts "Lesson created successfully"

# Add comments
puts "Creating comments..."
Comment.find_or_create_by!(content: 'Great lesson! Looking forward to practicing these patterns.') do |comment|
  comment.user = student
  comment.lesson = lesson
end

Comment.find_or_create_by!(content: 'Glad you found it helpful! Let me know if you have any questions.') do |comment|
  comment.user = teacher
  comment.lesson = lesson
end

puts "Seed data created successfully!"
