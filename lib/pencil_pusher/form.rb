require 'active_model'
require 'virtus'

module PencilPusher
  class Form
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
    include Virtus.model

    attr_reader :data

    def self.attribute_names
      attribute_set.to_a.map(&:name)
    end

    def initialize(data)
      super(data)
      if data.nil?
        @validated = true
        @bound = false
        @data = {}
      else
        @validated = false
        @bound = true
        @data = data
      end
      errors.clear
    end

    after_validation :notify_validated

    def valid?
      @_valid ||= (
        if bound?
          super
        else
          true
        end
      )
    end

    def error_messages
      @_error_messages ||= errors.messages.dup
    end

    def cleaned_data
      attributes.reject { |key, value| value.nil? }
    end

    def recognized_data
      data.slice(*attributes.keys)
    end

    def bound?
      @bound
    end

    private :attributes
    private

    def validated?
      @validated
    end

    def notify_validated
      @validated = true
    end

  end
end
