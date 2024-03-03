# frozen_string_literal: true

return if Category.any?

%w[
  Fiction
  Non-Fiction
  Mystery
  Romance
  Science-Fiction
  Fantasy
  Biography
  History
].each { |genre| Category.create!(name: genre) }
