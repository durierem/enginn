# frozen_string_literal: true

RSpec.describe Enginn do
  def set_config
    Enginn.configure do |config|
      config.base_url = 'http://example.com/api/v1'
      config.api_token = '12345'
    end
  end

  after do
    described_class.config = nil
  end

  before do
    stub_request(:get, 'http://example.com/api/v1/colors/').with(headers: {
      'Accept' => '*/*',
      'Authorization' => 'Bearer 12345',
      'Content-Type' => 'application/json'
    }).to_return(status: 200, headers: { 'Content-Type' => 'application/json' }, body: JSON.dump(
      status: 200, result: { id: 42, project_id: 66, name: 'white', code: '#ffffff' }
    ))
  end

  describe '.configure' do
    it 'yields a Config object' do
      expect { |foo| described_class.configure(&foo) }.to yield_with_args(Enginn::Config)
    end
  end

  describe '.connect!' do
    context 'when the configuration is complete' do
      before { set_config }

      it 'yields a Faraday::Connection object' do
        expect { |foo| described_class.connect!(&foo) }.to yield_with_args(Faraday::Connection)
      end

      it 'sets the Content-Type header' do
        described_class.connect! do |conn|
          expect(conn.headers['Content-Type']).to eq('application/json')
        end
      end

      it 'sets the Authorization header' do
        described_class.connect! do |conn|
          expect(conn.headers['Authorization']).to eq('Bearer 12345')
        end
      end
    end

    context 'with missing configuration' do
      it 'raises an Enginn::ConfigError' do
        expect { |foo| described_class.connect!(&foo) }.to raise_error(Enginn::ConfigError)
      end
    end
  end

  describe '.request' do
    context 'with missing configuration' do
      it 'raises an Enginn::ConfigError' do
        expect { described_class.request(:get, 'colors') }.to raise_error(Enginn::ConfigError)
      end
    end

    context 'when the configuration is complete' do
      before { set_config }

      it 'returns a Hash corresponding to the API response' do
        expect(described_class.request(:get, 'colors')).to eq(
          status: 200, result: { id: 42, project_id: 66, name: 'white', code: '#ffffff' }
        )
      end
    end
  end
end
