# frozen_string_literal: true

redis_url = ENV['CUSTOM_REDIS_URL'].present? ? ENV['CUSTOM_REDIS_URL'] : ENV['REDIS_URL']
Sidekiq.configure_client do |config|
    config.redis = { url: redis_url, size: 2, network_timeout: 5, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end
  
  Sidekiq.configure_server do |config|
    config.redis = { url: redis_url, size: 42, network_timeout: 5, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
    config.average_scheduled_poll_interval = 3
  
    # Rails.application.config.after_initialize do
    #   Rails.logger.info("DB Pool size for Sidekiq Server before disconnect: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
    #   ActiveRecord::Base.connection_pool.disconnect!
    #
    #   ActiveSupport.on_load(:active_record) do
    #     config = Rails.application.config.database_configuration[Rails.env]
    #     config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
    #     # config['pool'] = ENV['WORKER_DB_POOL_SIZE'] || Sidekiq.options[:concurrency]
    #     config['pool'] = 16
    #     ActiveRecord::Base.establish_connection(config)
    #
    #     Rails.logger.info("DB Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
    #   end
    # end
  end
  