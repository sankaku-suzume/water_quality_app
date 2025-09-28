# frozen_string_literal: true

module ResultDecorator
  def violated?
    if test_item.standard_max
      if value.to_f > test_item.standard_max
        'violated'
      elsif test_item.standard_min
        if value.to_f < test_item.standard_min
          'violated'
        end
      end
    end
  end
end
