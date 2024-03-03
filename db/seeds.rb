# frozen_string_literal: true

Rails.logger.debug '###############'
Rails.logger.debug 'Seeding started'

require_relative 'seed/categories'
require_relative 'seed/users'
require_relative 'seed/bulletins'

Rails.logger.debug 'Seeding stopped'
Rails.logger.debug '###############'
