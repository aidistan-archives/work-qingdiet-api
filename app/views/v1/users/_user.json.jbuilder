json.(user, :id, :username, :created_at, :updated_at)

# Show user level for internal apps
json.level user.level if App.levels[@current_app.level] >= App.levels['staff']
