require 'pencil_pusher/form'
require 'pencil_pusher/spec_helpers'
require 'pencil_pusher/validations/date_time_validator'

describe PencilPusher::Validations::DateTimeValidator do
  include PencilPusher::SpecHelpers

  context 'validations' do
    BLANK   = 'Blank'
    INVALID = 'Invalid'

    class ValidForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/date_time' => {
          format:   '%Y-%d-%m',
          messages: {
            blank:   BLANK,
            invalid: INVALID
          }
        }
    end

    def form(options={})
      ValidForm.new(options)
    end

    it 'is valid if the date can be coerced to a Date object' do
      form(date: '2013-31-12').should be_valid
    end

    context 'blank validation' do
      it 'is not valid if the date is an empty string' do
        form(date: ' ').should have_errors(:date, [BLANK])
      end

      it 'is not valid if the date is nil' do
        form(date: nil).should have_errors(:date, [BLANK])
      end
    end

    context 'invalid validation' do
      it 'is not valid if the date cannot be coerced to a Date object' do
        form(date: 'now').should have_errors(:date, [INVALID])
      end

      it 'is not valid if the date is in improper format' do
        form(date: '12-31-2013').should have_errors(:date, [INVALID])
      end
    end
  end

  context 'missing options' do
    class InvalidForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/date_time' => {}
    end

    def form(options={})
      InvalidForm.new(options)
    end

    it 'raises an exception if format option is missing' do
      expect {form(date: '2013-12-31').valid?}.to raise_error(KeyError, 'key not found: :format')
    end

    it 'raises an exception if messages option is missing' do
      expect {form.valid?}.to raise_error(KeyError, 'key not found: :messages')
    end
  end

  context 'missing messages' do
    class MissingMessagesForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/date_time' => {
          format: '%Y-%m-%d',
          messages: {}
        }
    end

    def form(options={})
      MissingMessagesForm.new(options)
    end

    it 'raises an exception if blank message is missing' do
      expect {form.valid?}.to raise_error(KeyError, 'key not found: :blank')
    end

    it 'raises an exception if invalid message is missing' do
      expect {form(date: 'now').valid?}.to raise_error(KeyError, 'key not found: :invalid')
    end
  end
end
