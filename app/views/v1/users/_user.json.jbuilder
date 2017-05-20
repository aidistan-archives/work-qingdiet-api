json.(user, :id, :username, :gender)

# Format birthday as "YYYY-MM-DD"
json.birthday user.birthday ? user.birthday.to_date.to_formatted_s : ''

# Show user level for internal apps
json.level user.level if App.levels[@current_app.level] >= App.levels['staff']

# Show timestamps
json.(user, :created_at, :updated_at)
