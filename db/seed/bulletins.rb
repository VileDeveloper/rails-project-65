# frozen_string_literal: true

return if Bulletin.any?

10.times do |i|
  bulletin = Bulletin.new(title: Faker::Movies::HarryPotter.spell,
                          description: Faker::Quote.yoda,
                          user: User.last,
                          category: Category.all.sample,
                          state: :published)

  image_file = File.open("test/fixtures/files/empty_image#{i % 5}.png")
  bulletin.image.attach(io: image_file, filename: "empty_image#{i % 5}.png", content_type: 'image/png')
  bulletin.save!
end
