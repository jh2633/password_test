require 'bundler/setup'
namespace :server do
  desc 'Run the server'
  task :run do
    sh 'rackup', '--port', '4567', '--server', 'puma', '--host', '0.0.0.0'
  end
end
