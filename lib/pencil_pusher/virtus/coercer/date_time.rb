require 'virtus'
require 'date'

module PencilPusher
  module Virtus
    module Coercer
      class DateTime < ::Virtus::Attribute
        def initialize(type, options)
          @format = options.fetch(:format)
          super
        end

        def coerce(value)
          format_date(value)
        end

        private

        attr_reader :format

        def format_date(value)
          return value unless value.is_a?(Date)
          value.strftime(format)
        end
      end
    end
  end
end
