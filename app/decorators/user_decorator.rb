# frozen_string_literal: true

module UserDecorator
  def color_false?
    unless admin?
      'color_false'
    end
  end
end
