# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/messages'
require_relative 'runners/updates'

module Legion
  module Extensions
    module Telegram
      class Client
        include Helpers::Client
        include Runners::Messages
        include Runners::Updates

        attr_reader :opts

        def initialize(token:, **extra)
          @opts = { token: token, **extra }
        end

        def settings
          { options: @opts }
        end

        def connection(**override)
          super(**@opts, **override)
        end
      end
    end
  end
end
