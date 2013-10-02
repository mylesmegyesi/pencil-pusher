require 'virtus'
require 'date'

module PencilPusher
  module Virtus
    module Coercer
      class StrictDateTime < ::Virtus::Attribute
        def initialize(type, options)
          @format = options[:format]
          super
        end

        def coerce(value)
          return nil if value.nil?
          coerce_date(value)
        end

        private

        attr_reader :format

        def coerce_date(value)
          return value if value.is_a?(Date)
          if format
            DateTime.strptime(value, format)
          else
            Date.parse(value)
          end
        rescue ArgumentError
          nil
        end
      end
    end
  end
end
