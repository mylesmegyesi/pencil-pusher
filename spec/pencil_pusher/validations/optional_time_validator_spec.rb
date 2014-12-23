require 'pencil_pusher/form'
require 'pencil_pusher/spec_helpers'
require 'pencil_pusher/validations/optional_time_validator'

describe PencilPusher::Validations::OptionalTimeValidator do
  include PencilPusher::SpecHelpers

  context 'validations' do
    context 'time' do
      class ValidOptionalTimeForm < PencilPusher::Form
        INVALID = 'Invalid'

        attribute :time, String

        validates :time,
          'pencil_pusher/validations/optional_time' => {
            format:   '%H:%M',
            messages: {invalid: INVALID}
          }
      end

      def form(options={})
        ValidOptionalTimeForm.new(options)
      end

      it 'is valid if the time can be coerced to a Time object' do
        expect(form(time: '23:56')).to be_valid
      end

      context 'blank validation' do
        it 'is valid if the time is an empty string' do
          expect(form(time: ' ')).not_to have_errors(:time)
        end

        it 'is valid if the time is nil' do
          expect(form(time: nil)).not_to have_errors(:time)
        end
      end

      context 'invalid validation' do
        it 'is not valid if the time cannot be coerced to a Time object' do
          expect(form(time: 'now')).to have_errors(:time, [ValidTimeForm::INVALID])
        end

        it 'is not valid if the time is in improper format' do
          expect(form(time: '59:12')).to have_errors(:time, [ValidTimeForm::INVALID])
        end
      end
    end
  end

  context 'missing format option' do
    class MissingFormatForOptionalTimeForm < PencilPusher::Form
      attribute :time, String

      validates :time,
        'pencil_pusher/validations/optional_time' => {}
    end

    def form(options={})
      MissingFormatForOptionalTimeForm.new(options)
    end

    it 'raises an exception if format option is missing' do
      expect {form(time: '2013-12-31').valid?}.to raise_error(KeyError, 'key not found: :format')
    end
  end

  context 'missing format option' do
    class MissingMessagesForOptionalTimeForm < PencilPusher::Form
      attribute :time, String

      validates :time,
        'pencil_pusher/validations/optional_time' => {format: '%H-%M'}
    end

    def form(options={})
      MissingMessagesForOptionalTimeForm.new(options)
    end

    it 'raises an exception if messages option is missing' do
      expect {form(time: 'now').valid?}.to raise_error(KeyError, 'key not found: :messages')
    end
  end

  context 'missing messages' do
    class MissingInvalidMessageForOptionalTimeForm < PencilPusher::Form
      attribute :time, String

      validates :time,
        'pencil_pusher/validations/optional_time' => {
          format: '%H-%M',
          messages: {}
        }
    end

    def form(options={})
      MissingInvalidMessageForOptionalTimeForm.new(options)
    end

    it 'raises an exception if invalid message is missing' do
      expect {form(time: 'now').valid?}.to raise_error(KeyError, 'key not found: :invalid')
    end
  end
end
