# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']
      user = find_or_initialize_user(auth)

      if user.save
        sign_in(user)
        redirect_to root_path, notice: t('.success')
      else
        redirect_to new_user_path
      end
    end

    def logout
      sign_out

      redirect_to root_path, notice: t('.success')
    end

    private

    def find_or_initialize_user(auth)
      user = User.find_or_initialize_by(email: auth[:info][:email].downcase)

      return user if user.persisted?

      user.assign_attributes(build_auth_user_params(auth))
      user.oauth_data.build(build_oauth_data_params(auth))

      user
    end

    def build_auth_user_params(auth)
      {
        name: auth['info']['name'],
        email: auth['info']['email'],
        admin: true
      }
    end

    def build_oauth_data_params(auth)
      {
        provider: auth['provider'],
        uid: auth['uid'],
        response_body: auth
      }
    end
  end
end
