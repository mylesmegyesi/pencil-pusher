require 'pencil_pusher/form'
require 'pencil_pusher/spec_helpers'
require 'pencil_pusher/validations/time_validator'

describe PencilPusher::Validations::TimeValidator do
  include PencilPusher::SpecHelpers

  context 'validations' do
    context 'time' do
      class ValidTimeForm < PencilPusher::Form
        BLANK   = 'Blank'
        INVALID = 'Invalid'

        attribute :time, String

        validates :time,
          'pencil_pusher/validations/time' => {
            format:   '%H:%M',
            messages: {
              blank:   BLANK,
              invalid: INVALID
            }
          }
      end

      def form(options={})
        ValidTimeForm.new(options)
      end

      it 'is valid if the time can be coerced to a Time object' do
        form(time: '23:56').should be_valid
      end

      context 'blank validation' do
        it 'is not valid if the time is an empty string' do
          form(time: ' ').should have_errors(:time, [ValidTimeForm::BLANK])
        end

        it 'is not valid if the time is nil' do
          form(time: nil).should have_errors(:time, [ValidTimeForm::BLANK])
        end
      end

      context 'invalid validation' do
        it 'is not valid if the time cannot be coerced to a Time object' do
          form(time: 'now').should have_errors(:time, [ValidTimeForm::INVALID])
        end

        it 'is not valid if the time is in improper format' do
          form(time: '59:12').should have_errors(:time, [ValidTimeForm::INVALID])
        end
      end
    end
  end

  context 'missing options' do
    class InvalidTimeForm < PencilPusher::Form
      attribute :time, String

      validates :time,
        'pencil_pusher/validations/time' => {}
    end

    def form(options={})
      InvalidTimeForm.new(options)
    end

    it 'raises an exception if format option is missing' do
      expect {form(time: '2013-12-31').valid?}.to raise_error(KeyError, 'key not found: :format')
    end

    it 'raises an exception if messages option is missing' do
      expect {form.valid?}.to raise_error(KeyError, 'key not found: :messages')
    end
  end

  context 'missing messages' do
    class MissingMessagesForTimeForm < PencilPusher::Form
      attribute :time, String

      validates :time,
        'pencil_pusher/validations/time' => {
          format: '%Y-%m-%d',
          messages: {}
        }
    end

    def form(options={})
      MissingMessagesForTimeForm.new(options)
    end

    it 'raises an exception if blank message is missing' do
      expect {form.valid?}.to raise_error(KeyError, 'key not found: :blank')
    end

    it 'raises an exception if invalid message is missing' do
      expect {form(time: 'now').valid?}.to raise_error(KeyError, 'key not found: :invalid')
    end
  end
end
