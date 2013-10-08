require 'pencil_pusher/form'
require 'pencil_pusher/spec_helpers'
require 'pencil_pusher/validations/date_time_validator'

describe PencilPusher::Validations::DateTimeValidator do
  include PencilPusher::SpecHelpers

  context 'validations' do
    class ValidForm < PencilPusher::Form
      attribute :date, String

      validates :date,
        'pencil_pusher/validations/date_time' => {format: '%Y-%d-%m', message: 'Invalid'}
    end

    def form(options={})
      ValidForm.new(options)
    end

    it 'is valid if the date can be coerced to a Date object' do
      form(date: '2013-31-12').should be_valid
    end

    it 'is not valid if the date cannot be coerced to a Date object' do
      form(date: 'now').should have_errors(:date, ['Invalid'])
    end

    it 'is not valid if the date is in improper format' do
      form(date: '12-31-2013').should have_errors(:date, ['Invalid'])
    end

    it 'is not valid if the date is nil' do
      form(date: nil).should have_errors(:date, ['Invalid'])
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
      expect {form(date: '2013-12-31').valid?}.to raise_error(KeyError)
    end

    it 'raises an exception if message option is missing' do
      expect {form.valid?}.to raise_error(KeyError)
    end
  end
end
