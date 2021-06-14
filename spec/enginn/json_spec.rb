# frozen_string_literal: true

RSpec.describe JSON do
  describe '.safe_parse' do
    context 'when the given argument is unparsable' do
      it 'returns nil' do
        expect(JSON.safe_parse('not a JSON')).to be_nil
      end
    end

    context 'when the given argument is parsable' do
      it 'returns a hash representing the given JSON with symbolized keys' do
        expect(JSON.safe_parse('{"foo": 1, "bar": "hello"}')).to eq(foo: 1, bar: 'hello')
      end
    end
  end
end
