module PencilPusher
  module Validations
    class OptionalDateTimeValidator < ActiveModel::EachValidator
      def validate_each(model, attribute, value)
        @model     = model
        @attribute = attribute

        return if blank?(value)
        coerce_date(value)
      end

      private

      attr_reader :model, :attribute

      def messages
        @messages ||= options.fetch(:messages)
      end

      def coerce_date(value)
        Date.strptime(value, options.fetch(:format))
      rescue ArgumentError
        append_invalid_message
      end

      def blank?(value)
        value.nil? || value.strip == ''
      end

      def append_invalid_message
        model.errors.add(attribute, messages.fetch(:invalid))
      end
    end
  end
end
