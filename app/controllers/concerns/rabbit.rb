class Rabbit

  class << self

    def default_exchange_name
      @default_exchange_name ||= 'top_mq'.freeze
    end


    def publish(routing_key, message, exchange_name = default_exchange_name)
      exchange = channel.topic(exchange_name)
      puts "publish: #{message} to #{message.to_json}"
      exchange.publish(message.to_json, :routing_key => routing_key )
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new.tap do |c|
        c.start
      end
    end

    def subscribe(queue_name, routing_key, exchange_name = default_exchange_name)
      exchange = channel.topic(exchange_name)
      channel.queue(queue_name).bind(exchange, :routing_key => routing_key).subscribe do |delivery_info, properties, payload|
        yield JSON.parse(payload).with_indifferent_access
      end
    end

  end
end