source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use HAML as the template engine
gem 'haml'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use UUIDTools to generate uuids
gem 'uuidtools'
# Use Pundit for action authorizations
gem 'pundit'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use rubocop to unify the styles of our codes
  gem 'rubocop'
end
