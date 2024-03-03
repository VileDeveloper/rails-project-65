# frozen_string_literal: true

class CreateOauthData < ActiveRecord::Migration[7.0]
  def change
    create_table :oauth_data do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uid, null: false
      t.string :provider, null: false
      t.json :response_body

      t.timestamps
    end
  end
end
