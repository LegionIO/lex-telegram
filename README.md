# lex-telegram

Telegram Bot API integration for [LegionIO](https://github.com/LegionIO/LegionIO). Send messages, manage webhooks, and handle updates from within Legion task chains or as a standalone client library.

## Installation

```bash
gem install lex-telegram
```

Or add to your Gemfile:

```ruby
gem 'lex-telegram'
```

## Standalone Usage

```ruby
require 'legion/extensions/telegram'

client = Legion::Extensions::Telegram::Client.new(token: 'BOT_TOKEN')

# Messages
client.send_message(chat_id: 12345, text: 'Hello from Legion!')
client.send_message(chat_id: 12345, text: '*Bold*', parse_mode: 'Markdown')
client.edit_message(chat_id: 12345, message_id: 1, text: 'Updated text')
client.delete_message(chat_id: 12345, message_id: 1)
client.forward_message(chat_id: 12345, from_chat_id: 67890, message_id: 42)

# Updates
client.get_updates(offset: 100, limit: 10, timeout: 30)
client.set_webhook(url: 'https://mybot.example.com/webhook')
client.delete_webhook
client.get_webhook_info
```

## Runners

### Messages

| Method | Parameters | Description |
|--------|-----------|-------------|
| `send_message` | `chat_id:`, `text:`, `parse_mode:`, ... | Send a text message |
| `edit_message` | `chat_id:`, `message_id:`, `text:` | Edit an existing message |
| `delete_message` | `chat_id:`, `message_id:` | Delete a message |
| `forward_message` | `chat_id:`, `from_chat_id:`, `message_id:` | Forward a message |

### Updates

| Method | Parameters | Description |
|--------|-----------|-------------|
| `get_updates` | `offset:`, `limit:`, `timeout:` | Long-poll for updates |
| `set_webhook` | `url:`, `max_connections:`, ... | Set a webhook URL |
| `delete_webhook` | — | Remove the webhook |
| `get_webhook_info` | — | Get current webhook status |

## Configuration

```json
{
  "lex-telegram": {
    "token": "vault://secret/telegram#bot_token"
  }
}
```

## Authentication

The bot token is embedded in the API URL path: `https://api.telegram.org/bot<TOKEN>/<method>`. Create a bot via [@BotFather](https://t.me/BotFather) to obtain a token.

## Requirements

- Ruby >= 3.4
- `faraday` >= 2.0

## License

MIT
