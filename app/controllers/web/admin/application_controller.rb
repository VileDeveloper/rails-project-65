# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :require_admin!
      layout 'admin'
    end
  end
end
