require 'pencil_pusher/form'
require 'pencil_pusher/spec_helpers'
require 'pencil_pusher/validations/optional_date_time_validator'

describe PencilPusher::Validations::OptionalDateTimeValidator do
  include PencilPusher::SpecHelpers

  context 'validations' do
    context 'date' do
      class OptionalValidDateForm < PencilPusher::Form
        INVALID = 'Invalid'

        attribute :date, String

        validates :date,
          'pencil_pusher/validations/optional_date_time' => {
            format:   '%Y-%d-%m',
            messages: {invalid: INVALID}
          }
      end

      def form(options={})
        OptionalValidDateForm.new(options)
      end

      it 'is valid if the date can be coerced to a Date object' do
        form(date: '2013-31-12').should be_valid
      end

      context 'blank validation' do
        it 'is valid if the date is an empty string' do
          form(date: ' ').should_not have_errors(:date)
        end

        it 'is valid if the date is nil' do
          form(date: nil).should_not have_errors(:date)
        end
      end

      context 'invalid validation' do
        it 'is not valid if the date cannot be coerced to a Date object' do
          form(date: 'now').should have_errors(:date, [ValidDateForm::INVALID])
        end

        it 'is not valid if the date is in improper format' do
          form(date: '12-31-2013').should have_errors(:date, [ValidDateForm::INVALID])
        end
      end
    end
  end

  context 'missing options' do
    class OptionalInvalidDateForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/optional_date_time' => {}
    end

    def form(options={})
      OptionalInvalidDateForm.new(options)
    end

    it 'raises an exception if format option is missing' do
      expect {form(date: '2013-12-31').valid?}.to raise_error(KeyError, 'key not found: :format')
    end
  end

  context 'missing messages' do
    class OptionalMissingMessagesForDateForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/optional_date_time' => {
          format: '%Y-%m-%d',
          messages: {}
        }
    end

    def form(options={})
      OptionalMissingMessagesForDateForm.new(options)
    end

    it 'raises an exception if invalid message is missing' do
      expect {form(date: 'now').valid?}.to raise_error(KeyError, 'key not found: :invalid')
    end
  end
end
