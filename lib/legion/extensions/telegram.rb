# frozen_string_literal: true

require 'legion/extensions/telegram/version'
require 'legion/extensions/telegram/helpers/client'
require 'legion/extensions/telegram/runners/messages'
require 'legion/extensions/telegram/runners/updates'
require 'legion/extensions/telegram/client'

module Legion
  module Extensions
    module Telegram
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
