module PencilPusher
  class HaveTextField
    include PencilPusher::Matchers

    def initialize(field_name, valid_value)
      @field_name = field_name
      @valid_value = valid_value
    end

    def matches?(builder)
      begin
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
      "expected #{actual} to not have text field #{field_name} but did"
    end

    alias failure_message              failure_message_for_should
    alias failure_message_when_negated failure_message_for_should_not

    def description
      "have text field #{field_name}"
    end

    private

    attr_reader :field_name, :valid_value
  end
end
