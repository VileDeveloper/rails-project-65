# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @category = categories(:two)
        @category_with_bulletins = categories(:one)
        @user = users(:admin)

        sign_in(@user)
      end

      test 'admin should be get categories routes' do
        get admin_categories_path

        assert_response :success
      end

      test 'admin must have access to the creation category route' do
        get new_admin_category_path

        assert_response :success
      end

      test 'admin must have access to view category' do
        get edit_admin_category_path(@category)

        assert_response :success
      end

      test 'admin should be create category' do
        post admin_categories_url, params: { category: { name: 'Новая категория' } }

        assert(Category.find_by(name: 'Новая категория'))
      end

      test 'admin should be destroy category' do
        delete admin_category_url(@category)

        assert_nil(Category.find_by(name: @category.name))
      end

      test 'admin cannot destroy category with bulletins' do
        delete admin_category_url(@category_with_bulletins)

        assert(Category.find_by(name: @category_with_bulletins.name))
      end
    end
  end
end
