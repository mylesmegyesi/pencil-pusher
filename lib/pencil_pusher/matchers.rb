module PencilPusher
  module Matchers

    def have_errors(field_name, expected_errors=[])
      HaveErrors.new(field_name, expected_errors)
    end

    def have_required_field(field_name, error)
      HaveRequiredField.new(field_name, error)
    end

    def have_required_choice_field(field_name, valid_values, blank_error, invalid_error)
      HaveRequiredChoiceField.new(field_name, valid_values, blank_error, invalid_error)
    end

    def have_required_float_field(field_name, valid_value, blank_error, invalid_error)
      HaveRequiredFloatField.new(field_name, valid_value, blank_error, invalid_error)
    end

    def have_required_int_field(field_name, valid_value, blank_error, invalid_error)
      HaveRequiredIntField.new(field_name, valid_value, blank_error, invalid_error)
    end

    def have_int_field(field_name, valid_value, invalid_error)
      HaveIntField.new(field_name, valid_value, invalid_error)
    end

    def have_text_field(field_name, valid_value)
      HaveTextField.new(field_name, valid_value)
    end

    def have_required_text_field(field_name, valid_value, error)
      HaveRequiredTextField.new(field_name, valid_value, error)
    end

  end
end
