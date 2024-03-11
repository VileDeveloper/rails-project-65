# frozen_string_literal: true

require 'test_helper'
module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @bulletin_draft = bulletins(:three)
        @bulletin_under_moderation = bulletins(:four)
        @user = users(:admin)

        sign_in(@user)
      end

      test 'admin should get index' do
        get admin_root_path

        assert_response :success
      end

      test 'admin should get show' do
        get bulletin_url(@bulletin_draft)

        assert_response :success
      end

      test 'admin should make transition to publish from under_moderation' do
        patch publish_admin_bulletin_path(@bulletin_under_moderation)

        @bulletin_under_moderation.reload
        assert @bulletin_under_moderation.published?
      end

      test 'admin should make transition to reject from under_moderation' do
        patch reject_admin_bulletin_path(@bulletin_under_moderation)

        @bulletin_under_moderation.reload
        assert @bulletin_under_moderation.rejected?
      end

      test 'admin should make transition to archived from under_moderation' do
        patch archive_admin_bulletin_path(@bulletin_under_moderation)

        @bulletin_under_moderation.reload
        assert @bulletin_under_moderation.archived?
      end

      test 'admin should make transition to published from draft' do
        patch publish_admin_bulletin_path(@bulletin_draft)

        @bulletin_draft.reload
        assert @bulletin_draft.draft?
      end
    end
  end
end
