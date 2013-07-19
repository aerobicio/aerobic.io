begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 10
    cane.add_threshold 'coverage/covered_percent', :>=, 99

    # The Fit Library is not our code, so don't hold it to our standards
    # just yet. If we want to own it, we should turn it into a Gem.
    cane.style_exclude = %w(lib/fit/**/**)
    cane.doc_exclude = %w(lib/fit.rb lib/fit/**/**)
    cane.abc_exclude = %w(Fit::File::Data.generate Fit::File::Record#read)
  end

  task :default => :quality
rescue LoadError
  warn "cane not available, quality task not provided."
end
