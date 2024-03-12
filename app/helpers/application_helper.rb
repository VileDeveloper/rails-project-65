# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    case type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    else
      'alert-info'
    end
  end

  def nav_menu_item(name, path = '#', options = {})
    class_names = class_names('nav-link', 'link-dark', { active: current_page?(path) })
    assembled_options = options.merge(class: class_names)

    tag.li class: 'nav-item' do
      link_to path, assembled_options do
        name
      end
    end
  end
end
