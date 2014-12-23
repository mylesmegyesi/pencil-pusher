require 'pencil_pusher/form'
require 'pencil_pusher/spec_helpers'
require 'pencil_pusher/validations/date_time_validator'

describe PencilPusher::Validations::DateTimeValidator do
  include PencilPusher::SpecHelpers

  context 'validations' do
    context 'date' do
      class ValidDateForm < PencilPusher::Form
        BLANK   = 'Blank'
        INVALID = 'Invalid'

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
        ValidDateForm.new(options)
      end

      it 'is valid if the date can be coerced to a Date object' do
        expect(form(date: '2013-31-12')).to be_valid
      end

      context 'blank validation' do
        it 'is not valid if the date is an empty string' do
          expect(form(date: ' ')).to have_errors(:date, [ValidDateForm::BLANK])
        end

        it 'is not valid if the date is nil' do
          expect(form(date: nil)).to have_errors(:date, [ValidDateForm::BLANK])
        end
      end

      context 'invalid validation' do
        it 'is not valid if the date cannot be coerced to a Date object' do
          expect(form(date: 'now')).to have_errors(:date, [ValidDateForm::INVALID])
        end

        it 'is not valid if the date is in improper format' do
          expect(form(date: '12-31-2013')).to have_errors(:date, [ValidDateForm::INVALID])
        end
      end
    end
  end

  context 'missing options' do
    class InvalidDateForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/date_time' => {}
    end

    def form(options={})
      InvalidDateForm.new(options)
    end

    it 'raises an exception if format option is missing' do
      expect {form(date: '2013-12-31').valid?}.to raise_error(KeyError, 'key not found: :format')
    end

    it 'raises an exception if messages option is missing' do
      expect {form.valid?}.to raise_error(KeyError, 'key not found: :messages')
    end
  end

  context 'missing messages' do
    class MissingMessagesForDateForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/date_time' => {
          format: '%Y-%m-%d',
          messages: {}
        }
    end

    def form(options={})
      MissingMessagesForDateForm.new(options)
    end

    it 'raises an exception if blank message is missing' do
      expect {form.valid?}.to raise_error(KeyError, 'key not found: :blank')
    end

    it 'raises an exception if invalid message is missing' do
      expect {form(date: 'now').valid?}.to raise_error(KeyError, 'key not found: :invalid')
    end
  end
end
