module PencilPusher
  class HaveRequiredChoiceField
    include PencilPusher::Matchers

    def initialize(field_name, valid_values, blank_error, invalid_error)
      @field_name = field_name
      @valid_values = valid_values
      @blank_error = blank_error
      @invalid_error = invalid_error
    end

    def matches?(form)
      begin
        form.should have_required_field(field_name, blank_error)
        builder = FormBuilder.builder(form)
        builder.call(field_name => 'invalid_value').should have_errors(field_name, [invalid_error])
        valid_values.each do |valid_value|
          builder.call(field_name => valid_value.to_s).should_not have_errors(field_name)
        end
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
      "expected #{actual} to not have required choice field #{field_name} but did"
    end

    alias failure_message               failure_message_for_should 
    alias failure_message_when_negated  failure_message_for_should_not

    def description
      "have required choice field #{field_name}"
    end

    private

    attr_reader :field_name, :blank_error, :invalid_error, :valid_values
  end
end
