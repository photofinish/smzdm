redis_host = '127.0.0.1'
redis_port = 6379
redis_password = nil
# redis_password = 'YSoBCNPEg0P8JMmhuf1fMBTldlY4rIQ0'
# # rails
# Rails.application.config.cache_store = :redis_store, {
#   host: redis_host,
#   port: redis_port,
#   db: 0,
#   password: redis_password,
#   namespace: "cache"
# }, { expires_in: 90.minutes }
#
# # redis
# $redis = Redis.new({
#                      host: redis_host,
#                      port: redis_port,
#                      db: 0,
#                      password: redis_password,
#                      namespace: "redis-data"
#                    })
#
# # redis-rack-cache
# # Rails.application.config.config.action_dispatch.rack_cache = {
# #   metastore: "redis://localhost:6379/0/metastore",
# #   entitystore: "redis://localhost:6379/0/entitystore"
# # }
#
# #Sidekiq
Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'highlander_sidekiq', url: "redis://#{redis_host}:#{redis_port}/0", password: redis_password }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'highlander_sidekiq', url: "redis://#{redis_host}:#{redis_port}/0" , password: redis_password }
end