require 'pencil_pusher/form'
require 'pencil_pusher/date_time_fields'
require 'pencil_pusher/spec_helpers'

describe PencilPusher::DateTimeFields do
  include PencilPusher::SpecHelpers

  context '#required_date_time_field' do
    class TestDateTimeFieldForm < PencilPusher::Form
      extend PencilPusher::DateTimeFields

      FORMAT = '%d-%m-%Y'

      required_date_time_field(
        field_name:      :start_date,
        format:          FORMAT,
        blank_message:   'Blank',
        invalid_message: 'Invalid'
      )
    end

    def form(options={})
      TestDateTimeFieldForm.new(options)
    end

    it 'requires field' do
      form({}).should have_errors(:start_date, ['Blank'])
    end

    it 'validates date value can be coerced to Date' do
      form(start_date: 'now').should have_errors(:start_date, ['Invalid'])
    end

    it 'validates date format' do
      form(start_date: '2013/01/01').should have_errors(:start_date, ['Invalid'])
    end

    it 'is valid' do
      form(start_date: '31-01-2013').should_not have_errors(:start_date)
    end
  end

  context '#required_time_field' do
    class TestTimeFieldForm < PencilPusher::Form
      extend PencilPusher::DateTimeFields

      FORMAT = '%H:%M'

      required_time_field(
        field_name:      :start_time,
        format:          FORMAT,
        blank_message:   'Blank',
        invalid_message: 'Invalid'
      )
    end

    def form(options={})
      TestTimeFieldForm.new(options)
    end

    it 'requires field' do
      form({}).should have_errors(:start_time, ['Blank'])
    end

    it 'validates time value can be coerced to Time' do
      form(start_time: 'now').should have_errors(:start_time, ['Invalid'])
    end

    it 'validates time format' do
      form(start_time: '59:12').should have_errors(:start_time, ['Invalid'])
    end

    it 'is valid' do
      form(start_time: '23:59').should_not have_errors(:start_time)
    end
  end
end
