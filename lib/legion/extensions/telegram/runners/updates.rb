# frozen_string_literal: true

module Legion
  module Extensions
    module Telegram
      module Runners
        module Updates
          def get_updates(offset: nil, limit: 100, timeout: 0, **opts)
            conn = opts.delete(:connection) || connection(**opts)
            params = { limit: limit, timeout: timeout }
            params[:offset] = offset if offset
            resp = conn.get('/getUpdates', params)
            resp.body
          end

          def set_webhook(url:, **opts)
            conn = opts.delete(:connection) || connection(**opts)
            body = { url: url }
            body[:max_connections] = opts[:max_connections] if opts[:max_connections]
            body[:allowed_updates] = opts[:allowed_updates] if opts[:allowed_updates]
            body[:secret_token]    = opts[:secret_token] if opts[:secret_token]
            resp = conn.post('/setWebhook', body)
            resp.body
          end

          def delete_webhook(**opts)
            conn = opts.delete(:connection) || connection(**opts)
            resp = conn.post('/deleteWebhook', {})
            resp.body
          end

          def get_webhook_info(**opts)
            conn = opts.delete(:connection) || connection(**opts)
            resp = conn.get('/getWebhookInfo')
            resp.body
          end
        end
      end
    end
  end
end
