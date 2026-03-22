# frozen_string_literal: true

RSpec.describe Legion::Extensions::Telegram::Runners::Messages do
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

  describe '#send_message' do
    it 'sends a message and returns the response body' do
      stubs.post('/sendMessage') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => { 'message_id' => 42, 'text' => 'Hello!' } }]
      end
      result = client.send_message(chat_id: '123', text: 'Hello!')
      expect(result['ok']).to be true
      expect(result['result']['message_id']).to eq(42)
    end

    it 'includes parse_mode when provided' do
      stubs.post('/sendMessage') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => { 'message_id' => 43 } }]
      end
      result = client.send_message(chat_id: '123', text: '*bold*', parse_mode: 'Markdown')
      expect(result['ok']).to be true
    end
  end

  describe '#edit_message' do
    it 'edits a message and returns the response body' do
      stubs.post('/editMessageText') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => { 'message_id' => 42, 'text' => 'Updated!' } }]
      end
      result = client.edit_message(chat_id: '123', message_id: 42, text: 'Updated!')
      expect(result['ok']).to be true
      expect(result['result']['text']).to eq('Updated!')
    end
  end

  describe '#delete_message' do
    it 'returns deleted true when result is true' do
      stubs.post('/deleteMessage') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => true }]
      end
      result = client.delete_message(chat_id: '123', message_id: 42)
      expect(result[:deleted]).to be true
      expect(result[:message_id]).to eq(42)
    end
  end

  describe '#forward_message' do
    it 'forwards a message and returns the response body' do
      stubs.post('/forwardMessage') do
        [200, { 'Content-Type' => 'application/json' },
         { 'ok' => true, 'result' => { 'message_id' => 99 } }]
      end
      result = client.forward_message(chat_id: '456', from_chat_id: '123', message_id: 42)
      expect(result['ok']).to be true
      expect(result['result']['message_id']).to eq(99)
    end
  end
end
