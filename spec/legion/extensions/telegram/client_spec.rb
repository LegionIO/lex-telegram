# frozen_string_literal: true

RSpec.describe Legion::Extensions::Telegram::Client do
  subject(:client) { described_class.new(token: 'test-bot-token') }

  describe '#initialize' do
    it 'stores token in opts' do
      expect(client.opts[:token]).to eq('test-bot-token')
    end
  end

  describe '#settings' do
    it 'returns a hash with options key' do
      expect(client.settings).to eq({ options: client.opts })
    end
  end

  describe '#connection' do
    it 'returns a Faraday connection' do
      expect(client.connection).to be_a(Faraday::Connection)
    end

    it 'builds URL with the bot token' do
      conn = client.connection
      expect(conn.url_prefix.to_s).to include('test-bot-token')
    end
  end
end
