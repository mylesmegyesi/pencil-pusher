module PencilPusher
  class HaveRequiredIntField
    include PencilPusher::Matchers
    include RSpec::Matchers

    def initialize(field_name, valid_value, blank_error, invalid_error)
      @field_name = field_name
      @valid_value = valid_value
      @blank_error = blank_error
      @invalid_error = invalid_error
    end

    def matches?(builder)
      begin
        expect(builder).to have_required_field(field_name, blank_error)
        expect(builder).to have_int_field(field_name, valid_value, invalid_error)
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
      "expected #{actual} to not have required int field #{field_name} but did"
    end

    alias failure_message              failure_message_for_should
    alias failure_message_when_negated failure_message_for_should_not

    def description
      "have required int field #{field_name}"
    end

    private

    attr_reader :field_name, :valid_value, :blank_error, :invalid_error
  end
end
