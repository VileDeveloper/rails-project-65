# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy
  has_many :oauth_data, class_name: 'OauthDatum', dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
