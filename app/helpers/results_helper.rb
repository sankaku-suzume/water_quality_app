module ResultsHelper
  def average(results)
    values = set_values(results)
    values.sum.fdiv(results.length)
  end

  def minimum(results)
    values = set_values(results)
    values.min
  end

  def maximum(results)
    values = set_values(results)
    values.max
  end

  private
  def set_values(results)
    values = []
    results.each do |result|
      value = result.value
      values.push(value)
    end
    values
  end
end