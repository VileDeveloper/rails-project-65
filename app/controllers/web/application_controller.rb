# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthManagement
    include Pundit::Authorization
    helper_method %i[sign_in sign_out signed_in? current_user require_signed_in_user! require_admin!]

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      redirect_to (request.referer || root_path), notice: t('bulletin_policy.login_or_registration', scope: 'pundit')
    end
  end
end
