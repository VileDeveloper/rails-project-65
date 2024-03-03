# frozen_string_literal: true

class OauthDatum < ApplicationRecord
  self.table_name = 'oauth_data'

  belongs_to :user
end
