json.array!(@posts) do |post|
  json.extract! post, :id, :title, :desc, :created_at, :updated_at
  json.is_admin current_user.is_admin if current_user
end


