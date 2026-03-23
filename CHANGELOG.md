# Changelog

## [0.1.2] - 2026-03-22

### Changed
- Add legion-cache, legion-crypt, legion-data, legion-json, legion-logging, legion-settings, and legion-transport as runtime dependencies
- Update spec_helper with real sub-gem helper stubs for Legion::Extensions::Helpers::Lex

## [0.1.0] - 2026-03-22

### Added
- Initial release
- `Helpers::Client` — Faraday connection builder targeting Telegram Bot API with token auth
- `Runners::Messages` — send_message, edit_message, delete_message, forward_message
- `Runners::Updates` — get_updates, set_webhook, delete_webhook, get_webhook_info
- Standalone `Client` class for use outside the Legion framework
