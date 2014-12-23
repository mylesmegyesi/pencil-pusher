module PencilPusher
  class HaveIntField
    include PencilPusher::Matchers
    include RSpec::Matchers

    def initialize(field_name, valid_value, error)
      @field_name = field_name
      @valid_value = valid_value
      @error = error
    end

    def matches?(builder)
      begin
        expect(FormBuilder.form(builder, {field_name => 'here'})).to have_errors(field_name, [error])
        expect(FormBuilder.form(builder, field_name => valid_value)).not_to have_errors(field_name)
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
      "expected #{actual} to not have int field #{field_name} but did"
    end

    alias failure_message              failure_message_for_should
    alias failure_message_when_negated failure_message_for_should_not

    def description
      "have int field #{field_name}"
    end

    private

    attr_reader :field_name, :valid_value, :error

  end
end
