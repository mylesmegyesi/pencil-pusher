module PencilPusher
  class HaveRequiredFloatField
    include PencilPusher::Matchers

    def initialize(field_name, valid_value, blank_error, invalid_error)
      @field_name = field_name
      @valid_value = valid_value
      @blank_error = blank_error
      @invalid_error = invalid_error
    end

    def matches?(builder)
      begin
        builder.should have_required_field(field_name, blank_error)
        FormBuilder.form(builder, {field_name => 'here'}).should have_errors(field_name, [invalid_error])
        FormBuilder.form(builder, field_name => valid_value).should_not have_errors(field_name)
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
      "expected #{actual} to not have required float field #{field_name} but did"
    end

    alias failure_message              failure_message_for_should
    alias failure_message_when_negated failure_message_for_should_not

    def description
      "have required float field #{field_name}"
    end

    private

    attr_reader :field_name, :valid_value, :blank_error, :invalid_error
  end
end
