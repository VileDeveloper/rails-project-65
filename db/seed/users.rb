# frozen_string_literal: true

return if User.any?

10.times do |_uid|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    admin: true
  )
end
