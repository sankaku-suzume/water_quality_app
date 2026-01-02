module ResultsHelper
  def average(results)
    values = set_values(results)
    values.sum.fdiv(results.length).round(decimal_places(results))
  end

  def minimum(results)
    values = set_values(results)
    values.min.round(decimal_places(results))
  end

  def maximum(results)
    values = set_values(results)
    values.max.round(decimal_places(results))
  end

  private
  def set_values(results)
    values = []
    results.each do |result|
      value = result.value
      values.push(value)
    end
    values.map(&:to_f)
  end

  def decimal_places(results)
    last_result = results.first
    decimal_index = last_result.value.reverse.index('.')
    if decimal_index
      decimal_index
    else
      0
    end
  end
end
