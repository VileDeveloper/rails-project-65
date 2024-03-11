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

    test 'should gen show' do
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

    test 'should update' do
      patch bulletin_path(@bulletin), params: { bulletin: { title: 'title after update' } }
      @bulletin.reload

      assert_equal('title after update', @bulletin.title)
    end

    test 'should make transition to under_moderation from draft' do
      patch to_moderate_bulletin_path(@bulletin)

      @bulletin.reload

      assert @bulletin.under_moderation?
    end

    test 'should make transition to archived from draft' do
      patch archive_bulletin_path(@bulletin)

      @bulletin.reload

      assert @bulletin.archived?
    end

    test 'should not make transition to under_moderation from archive' do
      @bulletin_archived = bulletins(:five)

      patch to_moderate_bulletin_path(@bulletin_archived)

      @bulletin_archived.reload

      assert @bulletin_archived.archived?
    end
  end
end
