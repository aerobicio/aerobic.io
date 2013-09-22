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

SimpleCov.start "rails" do
  # The Fit Library is not our code, so don't hold it to our standards
  # just yet. If we want to own it, we should turn it into a Gem.
  add_filter "lib/fit"
end
