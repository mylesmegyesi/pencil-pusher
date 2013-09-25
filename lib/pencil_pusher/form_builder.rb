module PencilPusher
  module FormBuilder
    def self.form(builder, data)
      case
      when builder.is_a?(Proc)
        builder.call(data)
      when builder.is_a?(Class)
        builder.new(data)
      else
        raise 'wat'
      end
    end

    def self.builder(form)
      case
      when form.is_a?(Proc)
        form
      when form.is_a?(Class)
        ->(data) {form.new(data)}
      else
        raise 'wat'
      end
    end
  end
end
