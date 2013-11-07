require "ostruct"

class ProcessFitFile
  include Interactor

  def perform
    fit = context[:activity]
    name = fit.lines.first

    fit = strip_casing(fit)
    fit = Base64.decode64(fit)

    context[:fit_file] = FitFile.new(fit_file_data_object(name, fit))
  end

  def fit_file_data_object(name, fit)
    { name: name, binary_data: fit }
  end

  def strip_casing(fit)
    fit = fit.lines.to_a[1..-1].join
    fit.lines.to_a[0..-2].join
  end
end
