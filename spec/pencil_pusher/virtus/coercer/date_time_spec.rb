require 'pencil_pusher/virtus/coercer/date_time'

describe PencilPusher::Virtus::Coercer::DateTime do
  context 'with date format option' do
    class TestDateTime
      include Virtus.model

      attribute :start_date, PencilPusher::Virtus::Coercer::DateTime, format: '%Y-%d-%m %H:%M'
    end

    def model(date=nil)
      TestDateTime.new(start_date: date)
    end

    it 'formats Date objects' do
      date = Date.today
      test_date_time = model(date)
      start_date = test_date_time.start_date
      expect(start_date).to eq(date.strftime('%Y-%d-%m %H:%M'))
    end

    it 'does not coerce a string' do
      date_string = 'date string'
      test_date_time = model(date_string)
      start_date = test_date_time.start_date
      expect(start_date).to eq(date_string)
    end

    it 'handles nil value' do
      test_date_time = model
      expect(test_date_time.start_date).to be_nil
    end
  end

  context 'without format option' do
    it 'raises an exception if date format is not provided' do
      expect {
        class TestDateTime
          include Virtus.model

          attribute :start_date, PencilPusher::Virtus::Coercer::DateTime
        end
      }.to raise_error(KeyError)
    end
  end
end
