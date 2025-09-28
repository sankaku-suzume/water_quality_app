# frozen_string_literal: true

require 'test_helper'

class ResultDecoratorTest < ActiveSupport::TestCase
  def setup
    @result = Result.new.extend ResultDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
