# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @category = categories(:one)
      @user = users(:admin)
      @bulletin = bulletins(:three)

      sign_in(@user)
    end

    test 'should get index' do
      get bulletins_path

      assert_response :success
    end

    test 'should show bulletin' do
      get bulletin_path(@bulletin)

      assert_response :success
    end

    test 'should get new' do
      get new_bulletin_path

      assert_response :success
    end

    test 'should create bulletin' do
      params =
        {
          bulletin:
            {
              title: 'New Bulletin',
              description: 'Description',
              category_id: @category.id,
              image: fixture_file_upload(
                Rails.root.join('test/fixtures/files/empty_image0.png'),
                'image/png'
              )
            }
        }

      post(bulletins_path, params:)
      @new_bulletin = Bulletin.find_by(title: 'New Bulletin')

      assert(@new_bulletin)
    end

    test 'should get edit' do
      get edit_bulletin_path(@bulletin)

      assert_response :success
    end

    test 'should update bulletin' do
      patch bulletin_path(@bulletin), params: { bulletin: { title: 'title after update' } }
      @bulletin.reload

      assert_equal('title after update', @bulletin.title)
    end

    test 'should submit bulletin for moderation' do
      patch to_moderate_bulletin_path(@bulletin)
      @bulletin.reload

      assert_equal('under_moderation', @bulletin.state)
    end

    test 'should archive bulletin' do
      assert_difference('Bulletin.archived.count') do
        patch archive_bulletin_path(@bulletin)
      end

      assert_redirected_to profile_path
      @bulletin.reload

      assert_equal('archived', @bulletin.state)
    end

    test 'user cannot change the ad status' do
      patch to_moderate_bulletin_path(@bulletin)
      @bulletin.reload
      patch publish_admin_bulletin_path(@bulletin)

      assert_equal('under_moderation', @bulletin.state)
    end

    test 'user cannot reject bulletin' do
      patch to_moderate_bulletin_path(@bulletin)
      @bulletin.reload
      patch reject_admin_bulletin_path(@bulletin)

      assert_equal('under_moderation', @bulletin.state)
    end
  end
end
