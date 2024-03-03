# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :user, inverse_of: :bulletins, optional: false
  belongs_to :category, inverse_of: :bulletins, optional: false

  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :image, presence: true, content_type: %i[png jpg jpeg webp], size: { less_than: 5.megabytes }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[under_moderation rejected draft published], to: :archived
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[state title category]
  end
end
