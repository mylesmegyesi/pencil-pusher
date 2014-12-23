module PencilPusher
  class HaveRequiredTextField
    include PencilPusher::Matchers
    include RSpec::Matchers

    def initialize(field_name, valid_value, error)
      @field_name = field_name
      @valid_value = valid_value
      @error = error
    end

    def matches?(builder)
      begin
        expect(builder).to have_required_field(field_name, error)
        expect(builder).to have_text_field(field_name, valid_value)
      rescue => e
        @error = e.message
        raise e
      end
      true
    end

    def failure_message_for_should(actual, two)
      @error
    end

    def failure_message_for_should_not(actual)
      "expected #{actual} to not have required text field #{field_name} but did"
    end

    alias failure_message              failure_message_for_should
    alias failure_message_when_negated failure_message_for_should_not

    def description
      "have required text field #{field_name}"
    end

    private

    attr_reader :field_name, :valid_value, :error
  end
end
