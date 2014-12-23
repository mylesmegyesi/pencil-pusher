module PencilPusher
  class HaveErrors
    def initialize(field_name, expected_errors=[])
      @field_name = field_name
      @expected_errors = expected_errors
    end

    def matches?(form)
      @actual = form
      valid = form.valid?
      if expected_errors.present?
        form.error_messages[field_name] == expected_errors
      else
        form.error_messages[field_name].present?
      end
    end

    def failure_message_for_should
      if errors = actual.error_messages[field_name].presence
        "expected field #{field_name} to have errors #{expected_errors} but had errors #{errors}"
      else
        "expected field #{field_name} to have errors #{expected_errors} but had no errors"
      end
    end

    def failure_message_for_should_not
      "expected no errors for field #{field_name} but found #{actual.error_messages[field_name]}"
    end

    alias failure_message               failure_message_for_should
    alias failure_message_when_negated  failure_message_for_should_not

    def description
      "have errors for #{field_name}"
    end

    private

    attr_reader :field_name, :expected_errors, :actual
  end
end
