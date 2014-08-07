module PencilPusher
  class HaveRequiredField
    include PencilPusher::Matchers

    def initialize(field_name, error)
      @field_name = field_name
      @error = error
    end

    def matches?(form)
      begin
        builder = FormBuilder.builder(form)
        builder.call(field_name => '').should have_errors(field_name, [error])
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
      "expected #{actual} to not have required field #{field_name} but did"
    end

    alias failure_message               failure_message_for_should 
    alias failure_message_when_negated  failure_message_for_should_not

    def description
      "have required field #{field_name}"
    end

    private

    attr_reader :field_name, :error
  end
end
