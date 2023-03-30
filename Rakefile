# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __dir__)
require 'sidekiq'
require 'sidekiq-cron'
require_relative "config/application"

Rails.application.load_tasks

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
