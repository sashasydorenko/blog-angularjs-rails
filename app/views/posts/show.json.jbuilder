json.extract! @post, :id, :title, :desc, :body, :created_at, :updated_at
json.is_admin current_user.is_admin if current_user
