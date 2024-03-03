# frozen_string_literal: true

module Web
  module Admin
    class HomeController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.under_moderation.order(created_at: :desc).page(params[:page]).per(25)
      end
    end
  end
end
