module PencilPusher
  module Validations
    class DateTimeValidator < ActiveModel::EachValidator
      def validate_each(model, attribute, value)
        @model     = model
        @attribute = attribute

        if value.nil?
          add_error
        else
          coerce_date(value)
        end
      end

      private

      attr_reader :model, :attribute

      def coerce_date(value)
        Date.strptime(value, options.fetch(:format))
      rescue ArgumentError
        add_error
      end

      def add_error
        model.errors[attribute] << options.fetch(:message)
      end
    end
  end
end

