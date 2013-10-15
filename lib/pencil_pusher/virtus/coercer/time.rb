require 'virtus'
require 'time'

module PencilPusher
  module Virtus
    module Coercer
      class Time < ::Virtus::Attribute
        def initialize(type, options)
          @format = options.fetch(:format)
          super
        end

        def coerce(value)
          format_time(value)
        end

        private

        attr_reader :format

        def format_time(value)
          return value unless value.is_a?(::Time)
          value.strftime(format)
        end
      end
    end
  end
end
