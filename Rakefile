require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'

  task :default => :spec

  desc 'Run specs'
  task :spec do
    RSpec::Core::RakeTask.new { |t| t.verbose = false }
  end
rescue LoadError => e
end
