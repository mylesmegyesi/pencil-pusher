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

  describe '#error_messages' do
    it 'returns error messages' do
      form = TestForm.new({})
      form.valid?

      expect(form.error_messages).to eq(test: ["can't be blank"])
    end

    it 'allows merging error messages when errors already present' do
      form = TestForm.new({})
      form.valid?
      form.error_messages.merge!(foo: ['error'])

      expect(form.error_messages).to eq(test: ["can't be blank"], foo: ['error'])
    end

    it 'allows merging error messages when no errors present' do
      form = TestForm.new({})
      form.error_messages.merge!(foo: ['error'])

      expect(form.error_messages).to eq(foo: ['error'])
    end
  end
end
