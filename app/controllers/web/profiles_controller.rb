# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    before_action :require_signed_in_user!

    def show
      @q = Bulletin.ransack(params[:q])

      @bulletins = Bulletin.ransack(params[:q])
                           .result
                           .where(user: current_user)
                           .order(updated_at: :desc)
                           .page params[:page]
    end
  end
end
