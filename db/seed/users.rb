# frozen_string_literal: true

return if User.any?

10.times do |uid|
  user =
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      admin: true
    )

  OauthDatum.create!(
    user:,
    uid:,
    provider: :github
  )
end
