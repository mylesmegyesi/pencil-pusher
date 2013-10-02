require 'pencil_pusher/virtus/coercer/strict_date_time'

describe PencilPusher::Virtus::Coercer::StrictDateTime do
  context 'without format option' do
    class TestStrictDateTime
      include Virtus.model

      attribute :start_date, PencilPusher::Virtus::Coercer::StrictDateTime
    end

    it 'coerces datetime' do
      test_strict_date_time = TestStrictDateTime.new(start_date: '31/12/2013')
      start_date = test_strict_date_time.start_date
      start_date.should_not be_nil
      start_date.day.should == 31
      start_date.month.should == 12
      start_date.year.should == 2013
    end

    it 'returns nil if the datetime cannot be coerced' do
      test_strict_date_time = TestStrictDateTime.new(start_date: 'now')
      test_strict_date_time.start_date.should be_nil
    end

    it 'handles non-string value' do
      test_strict_date_time = TestStrictDateTime.new(start_date: Date.today)
      test_strict_date_time.start_date.should_not be_nil
    end

    it 'handles nil value' do
      test_strict_date_time = TestStrictDateTime.new(start_date: nil)
      test_strict_date_time.start_date.should be_nil
    end
  end

  context 'with format option' do
    class TestStrictDateTimeWithFormat
      include Virtus.model

      attribute :start_date, PencilPusher::Virtus::Coercer::StrictDateTime, format: '%Y-%d-%m'
    end

    it 'optionally takes in a datetime format' do
      test_strict_date_time = TestStrictDateTimeWithFormat.new(start_date: '2013-02-11')
      start_date = test_strict_date_time.start_date
      start_date.should_not be_nil
      start_date.day.should == 2
      start_date.month.should == 11
      start_date.year.should == 2013
    end
  end
end
