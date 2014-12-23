require 'pencil_pusher/form'

describe PencilPusher::Form do
  I18n.enforce_available_locales = false

  class TestForm < PencilPusher::Form
    attribute :test, String
    attribute :another_test, Integer

    validates :test, presence: true
  end

  it 'is bound if it is given data' do
    expect(TestForm.new({}).bound?).to be_truthy
  end

  it 'is not bound if it is given no data' do
    expect(TestForm.new(nil).bound?).to be_falsey
  end

  it 'bound forms run validations' do
    expect(TestForm.new({}).valid?).to be_falsey
  end

  it 'unbound forms are always valid' do
    expect(TestForm.new(nil).valid?).to be_truthy
  end

  it 'returns recognized data' do
    expect(TestForm.new(test: 'here', unknown: 'here').recognized_data).to eq({test: 'here'})
  end

  it 'returns the attribute names' do
    expect(TestForm.attribute_names).to eq([:test, :another_test])
  end
end
