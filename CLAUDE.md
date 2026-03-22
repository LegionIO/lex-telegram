# lex-telegram: Telegram Bot API Integration for LegionIO

**Repository Level 4 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`

## Purpose

Legion extension for interacting with the Telegram Bot API. Supports sending, editing, deleting, and forwarding messages, as well as managing updates (long polling and webhooks).

**GitHub**: https://github.com/LegionIO/lex-telegram
**Gem**: `lex-telegram`
**Version**: 0.1.0
**License**: MIT
**Ruby**: >= 3.4

## Architecture

### Runners

| Runner | Methods | Description |
|--------|---------|-------------|
| `Messages` | `send_message`, `edit_message`, `delete_message`, `forward_message` | Core messaging operations |
| `Updates` | `get_updates`, `set_webhook`, `delete_webhook`, `get_webhook_info` | Bot update retrieval and webhook management |

### Helpers

- `Helpers::Client` — Faraday connection factory. Builds connection to `https://api.telegram.org/bot<token>/`. Token resolved from kwargs or `Legion::Settings[:'lex-telegram'][:token]`.

### Standalone Client

```ruby
client = Legion::Extensions::Telegram::Client.new(token: 'BOT_TOKEN')
client.send_message(chat_id: 12345, text: 'Hello from Legion!')
client.get_updates(limit: 10, timeout: 30)
```

## Authentication

Bot token in URL path per Telegram Bot API convention: `https://api.telegram.org/bot<TOKEN>/<method>`.

## Settings

```json
{
  "lex-telegram": {
    "token": "vault://secret/telegram#bot_token"
  }
}
```

## File Map

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/telegram.rb` | Entry point |
| `lib/legion/extensions/telegram/version.rb` | Version constant |
| `lib/legion/extensions/telegram/helpers/client.rb` | Faraday connection factory |
| `lib/legion/extensions/telegram/runners/messages.rb` | Message CRUD operations |
| `lib/legion/extensions/telegram/runners/updates.rb` | Update retrieval and webhook management |
| `lib/legion/extensions/telegram/client.rb` | Standalone Client class |

## Development

```bash
bundle install
bundle exec rspec       # 14 examples, 0 failures
bundle exec rubocop     # 0 offenses
```

---

**Maintained By**: Matthew Iverson (@Esity)
