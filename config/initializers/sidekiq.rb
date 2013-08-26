Sidekiq.configure_server do |config|
#    config.redis = { url: 'redis://localhost:6379', namespace: 'default' }
end

require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 2 }
end

