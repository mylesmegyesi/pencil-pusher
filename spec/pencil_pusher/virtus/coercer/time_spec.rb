require 'pencil_pusher/virtus/coercer/time'

describe PencilPusher::Virtus::Coercer::Time do
  context 'with time format option' do
    class TestTime
      include Virtus.model

      attribute :start_time, PencilPusher::Virtus::Coercer::Time, format: '%H:%M'
    end

    def model(time=nil)
      TestTime.new(start_time: time)
    end

    it 'formats Time objects' do
      time = Time.now.utc
      test_time = model(time)
      start_time = test_time.start_time
      start_time.should == time.strftime('%H:%M')
    end

    it 'does not coerce a string' do
      time_string = 'time string'
      test_time = model(time_string)
      start_time = test_time.start_time
      start_time.should == time_string
    end

    it 'handles nil value' do
      test_time = model
      test_time.start_time.should be_nil
    end
  end

  context 'without format option' do
    it 'raises an exception if time format is not provided' do
      expect {
        class TestTimeWithoutFormat
          include Virtus.model

          attribute :start_time, PencilPusher::Virtus::Coercer::Time
        end
      }.to raise_error(KeyError)
    end
  end
end
