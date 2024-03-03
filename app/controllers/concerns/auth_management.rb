# frozen_string_literal: true

module AuthManagement
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_signed_in_user!
    return if current_user

    redirect_back fallback_location: root_path, alert: t('bulletin_policy.login_or_registration', scope: 'pundit')
  end

  def require_admin!
    return if current_user&.admin?

    redirect_back fallback_location: root_path, alert: t('bulletin_policy.only_for_admin', scope: 'pundit')
  end

  private

  def reset_session
    session[:user_id] = nil
    @current_user = nil
  end
end
