require 'pencil_pusher/form'

describe PencilPusher::Form do

  class TestForm < PencilPusher::Form
    attribute :test, String
    attribute :another_test, Integer

    validates :test, presence: true
  end

  it 'is bound if it is given data' do
    TestForm.new({}).should be_bound
  end

  it 'is not bound if it is given no data' do
    TestForm.new(nil).should_not be_bound
  end

  it 'bound forms run validations' do
    TestForm.new({}).valid?.should be_false
  end

  it 'unbound forms are always valid' do
    TestForm.new(nil).valid?.should be_true
  end

  it 'returns recognized data' do
    TestForm.new(test: 'here', unknown: 'here').recognized_data.should == {test: 'here'}
  end

  it 'returns the attribute names' do
    TestForm.attribute_names.should == [:test, :another_test]
  end
end
