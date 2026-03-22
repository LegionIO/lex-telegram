# frozen_string_literal: true

RSpec.describe Legion::Extensions::Telegram::Runners::Updates do
  let(:client) { Legion::Extensions::Telegram::Client.new(token: 'test-bot-token') }

  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_connection) do
    Faraday.new(url: 'https://api.telegram.org/bottest-bot-token') do |conn|
      conn.request :json
      conn.response :json, content_type: /\bjson$/
      conn.adapter :test, stubs
    end
  end

  before { allow(client).to receive(:connection).and_return(test_connection) }

  describe '#get_updates' do
    it 'returns the response body with updates' do
      stubs.get('/getUpdates') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => [{ 'update_id' => 1 }, { 'update_id' => 2 }] }]
      end
      result = client.get_updates
      expect(result['ok']).to be true
      expect(result['result'].length).to eq(2)
    end

    it 'passes offset when provided' do
      stubs.get('/getUpdates') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => [] }]
      end
      result = client.get_updates(offset: 10)
      expect(result['ok']).to be true
    end
  end

  describe '#set_webhook' do
    it 'sets the webhook and returns the response body' do
      stubs.post('/setWebhook') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => true, 'description' => 'Webhook was set' }]
      end
      result = client.set_webhook(url: 'https://example.com/webhook')
      expect(result['ok']).to be true
      expect(result['result']).to be true
    end
  end

  describe '#delete_webhook' do
    it 'deletes the webhook and returns the response body' do
      stubs.post('/deleteWebhook') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => true, 'description' => 'Webhook was deleted' }]
      end
      result = client.delete_webhook
      expect(result['ok']).to be true
    end
  end

  describe '#get_webhook_info' do
    it 'returns webhook info' do
      stubs.get('/getWebhookInfo') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => { 'url' => 'https://example.com/webhook', 'has_custom_certificate' => false } }]
      end
      result = client.get_webhook_info
      expect(result['ok']).to be true
      expect(result['result']['url']).to eq('https://example.com/webhook')
    end
  end
end
