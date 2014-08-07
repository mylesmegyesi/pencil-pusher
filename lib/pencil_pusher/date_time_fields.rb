require 'pencil_pusher/validations/date_time_validator'
require 'pencil_pusher/validations/optional_date_time_validator'
require 'pencil_pusher/validations/optional_time_validator'
require 'pencil_pusher/validations/time_validator'
require 'pencil_pusher/virtus/coercer/date_time'
require 'pencil_pusher/virtus/coercer/time'

module PencilPusher
  module DateTimeFields
    def required_date_time_field(options={})
      field_name = options.fetch(:field_name)
      format     = options.fetch(:format)

      attribute field_name, PencilPusher::Virtus::Coercer::DateTime, format: format

      validates field_name,
        'pencil_pusher/validations/date_time' => {
          format:   format,
          messages: {
            blank:   options.fetch(:blank_message),
            invalid: options.fetch(:invalid_message)
          }
        }
    end

    def optional_date_time_field(options={})
      field_name = options.fetch(:field_name)
      format     = options.fetch(:format)

      attribute field_name, PencilPusher::Virtus::Coercer::DateTime, format: format

      validates field_name,
        'pencil_pusher/validations/optional_date_time' => {
          format:   format,
          messages: {invalid: options.fetch(:invalid_message)}
        }
    end

    def required_time_field(options={})
      field_name = options.fetch(:field_name)
      format     = options.fetch(:format)

      attribute field_name, PencilPusher::Virtus::Coercer::Time, format: format

      validates field_name,
        'pencil_pusher/validations/time' => {
          format:   format,
          messages: {
            blank:   options.fetch(:blank_message),
            invalid: options.fetch(:invalid_message)
          }
        }
    end

    def optional_time_field(options={})
      field_name = options.fetch(:field_name)
      format     = options.fetch(:format)

      attribute field_name, PencilPusher::Virtus::Coercer::Time, format: format

      validates field_name,
        'pencil_pusher/validations/optional_time' => {
          format:   format,
          messages: {invalid: options.fetch(:invalid_message)}
        }
    end
  end
end
