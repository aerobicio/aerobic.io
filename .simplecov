puts "SimpleCov Required"

class SimpleCov::Formatter::QualityFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    File.open("coverage/covered_percent", "w") do |f|
      f.puts result.source_files.covered_percent.to_f
    end
  end
end

SimpleCov.formatter = SimpleCov::Formatter::QualityFormatter

if suite_name = ENV["COVERAGE_GROUP"]
  SimpleCov.command_name(suite_name)
end

SimpleCov.start "rails"
