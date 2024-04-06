# Clear existing data to prevent duplication
User.destroy_all
UserProfile.destroy_all
Category.destroy_all
Post.destroy_all
Comment.destroy_all

# Create sample users
user1 = User.create!(email: 'user1@example.com', password: 'password', password_confirmation: 'password')
UserProfile.create!(nickname: 'Techie', bio: 'Loves coding and blogging about tech.', favorite_game: 'Chess', user: user1)
user2 = User.create!(email: 'user2@example.com', password: 'password', password_confirmation: 'password')
UserProfile.create!(nickname: 'Gamer', bio: 'Avid gamer and game development enthusiast.', favorite_game: 'The Witcher 3', user: user2)

# Create categories
tech = Category.create!(name: 'Technology')
gaming = Category.create!(name: 'Gaming')

# Create posts
post1 = Post.create!(title: 'The Future of Technology', content: 'Exploring upcoming trends in technology...', user: user1)
post2 = Post.create!(title: 'Introduction to Game Development', content: 'Game development is both art and science...', user: user2)

# Associate posts with categories through join table
post1.categories << tech
post2.categories << gaming

# Create comments
Comment.create!(content: 'Great read!', user: user2, post: post1)
Comment.create!(content: 'Looking forward to more posts like this.', user: user1, post: post2)

puts "Seed data created!"
