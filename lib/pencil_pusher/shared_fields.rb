module PencilPusher
  module SharedFields

    def required_int_field(field_name, blank_message, invalid_message)
      attribute field_name, Integer

      validates field_name,
        presence: {message: blank_message},
        numericality: {allow_blank: true,
                       only_integer: true,
                       message: invalid_message}
    end
  end
end
