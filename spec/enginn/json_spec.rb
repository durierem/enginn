# frozen_string_literal: true

RSpec.describe Enginn::JSON do
  describe '.safe_parse' do
    context 'when the given argument is unparsable' do
      it 'returns nil' do
        expect(described_class.safe_parse('not a JSON')).to be_nil
      end
    end

    context 'when the given argument is parsable' do
      it 'returns the same as JSON.parse' do
        json = '{"foo": 1, "bar": "hello"}'
        expect(described_class.safe_parse(json)).to eq(JSON.parse(json))
      end
    end
  end
end
