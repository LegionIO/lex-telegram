# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Telegram
      module Helpers
        module Client
          def connection(token: nil, **_opts)
            t = if token
                  token
                elsif defined?(Legion::Settings) && Legion::Settings.respond_to?(:dig)
                  Legion::Settings.dig(:'lex-telegram', :token)
                end
            Faraday.new(url: "https://api.telegram.org/bot#{t}") do |f|
              f.request :json
              f.response :json, content_type: /\bjson$/
              f.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
