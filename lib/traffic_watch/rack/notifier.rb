require "socket"
require "pry"

module TrafficWatch
  module Rack
    class Notifier
      attr_reader :app

      def initialize(app)
        @app = app
      end

      def call(env)
        binding.pry
        notify(:begin)
        app.call(env)
      ensure
        notify(:end)
      end

    private

      def notify(message)
        UDPSocket.new.send(message, 0, "127.0.0.1", 4913)
      end

    end
  end
end
