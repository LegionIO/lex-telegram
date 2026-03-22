# frozen_string_literal: true

module Legion
  module Extensions
    module Telegram
      module Runners
        module Messages
          def send_message(chat_id:, text:, **opts)
            conn = opts.delete(:connection) || connection(**opts)
            body = { chat_id: chat_id, text: text }
            body[:parse_mode]          = opts[:parse_mode] if opts[:parse_mode]
            body[:reply_to_message_id] = opts[:reply_to_message_id] if opts[:reply_to_message_id]
            resp = conn.post('/sendMessage', body)
            resp.body
          end

          def edit_message(chat_id:, message_id:, text:, **opts)
            conn = opts.delete(:connection) || connection(**opts)
            body = { chat_id: chat_id, message_id: message_id, text: text }
            body[:parse_mode] = opts[:parse_mode] if opts[:parse_mode]
            resp = conn.post('/editMessageText', body)
            resp.body
          end

          def delete_message(chat_id:, message_id:, **opts)
            conn = opts.delete(:connection) || connection(**opts)
            resp = conn.post('/deleteMessage', { chat_id: chat_id, message_id: message_id })
            deleted = resp.body.is_a?(Hash) && resp.body['result'] == true
            { deleted: deleted, message_id: message_id }
          end

          def forward_message(chat_id:, from_chat_id:, message_id:, **opts)
            conn = opts.delete(:connection) || connection(**opts)
            body = { chat_id: chat_id, from_chat_id: from_chat_id, message_id: message_id }
            resp = conn.post('/forwardMessage', body)
            resp.body
          end
        end
      end
    end
  end
end
