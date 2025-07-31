# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.40.0 - July 24, 2025
### Added
- Support disabling Agent mode when it's disabled by policy.

## 0.39.0 - July 23, 2025
### Fixed
- Performance: Fixed a freezing issue in 'Add Context' view when opening large projects.
- Login failed due to insufficient permissions on the .config folder.
- Fixed an issue that setting changes like proxy config did not take effect.
- Increased the timeout for ask mode to prevent response failures due to timeout.

## 0.38.0 - June 30, 2025
### Added
- Support for Claude 4 in Chat.
- Support for Copilot Vision (image attachments).
- Support for remote MCP servers.

### Changed
- Automatically suggests a title for conversations created in agent mode.
- Improved restoration of MCP tool status after Copilot restarts.
- Reduced duplication of MCP server instances.

### Fixed
- Switching accounts now correctly refreshes the auth token and models.
- Fixed file create/edit issues in agent mode.

## 0.37.0 - June 18, 2025
### Added
- **Advanced** settings: Added option to configure **Custom Instructions** for GitHub Copilot during chat sessions.
- **Advanced** settings: Added option to keep the chat window automatically attached to Xcode.

### Changed
- Enabled support for dragging-and-dropping files into the chat panel to provide context.

### Fixed
- "Add Context" menu didn’t show files in workspaces organized with Xcode’s group feature.
- Chat didn’t respond when the workspace was in a system folder (like Desktop, Downloads, or Documents) and access permission hadn’t been granted.

## 0.36.0 - June 4, 2025
### Added
- Introduced a new chat setting "**Response Language**" under **Advanced** settings to customize the natural language used in chat replies.
- Enabled support for custom instructions defined in _.github/copilot-instructions.md_ within your workspace.
- Added support for premium request handling.

### Fixed
- Performance: Improved UI responsiveness by lazily restoring chat history.
- Performance: Fixed lagging issue when pasting large text into the chat input.
- Performance: Improved project indexing performance.
- Don't trigger / (slash) commands when pasting a file path into the chat input.
- Adjusted terminal text styling to align with Xcode’s theme.

## 0.35.0 - May 19, 2025
### Added
- Launched Agent Mode. Copilot will automatically use multiple requests to edit files, run terminal commands, and fix errors.
- Introduced Model Context Protocol (MCP) support in Agent Mode, allowing you to configure MCP tools to extend capabilities.

### Changed
- Added a button to enable/disable referencing current file in conversations
- Added an animated progress icon in the response section
- Refined onboarding experience with updated instruction screens and welcome views
- Improved conversation reliability with extended timeout limits for agent requests

### Fixed
- Addressed critical error handling issues in core functionality
- Resolved UI inconsistencies with chat interface padding adjustments
- Implemented custom certificate handling using system environment variables `NODE_EXTRA_CA_CERTS` and `NODE_TLS_REJECT_UNAUTHORIZED`, fixing network access issues

## 0.34.0 - April 29, 2025
### Added
- Added support for new models in Chat: OpenAI GPT-4.1, o3 and o4-mini, Gemini 2.5 Pro

### Changed
- Switched default model to GPT-4.1 for new installations
- Enhanced model selection interface

### Fixed
- Resolved critical error handling issues

## 0.33.0 - April 17, 2025
### Added
- Added support for new models in Chat: Claude 3.7 Sonnet and GPT 4.5
- Implemented @workspace context feature allowing questions about the entire codebase in Copilot Chat

### Changed
- Simplified access to Copilot Chat from the Copilot for Xcode app with a single click
- Enhanced instructions for granting background permissions

### Fixed
- Resolved false alarms for sign-in and free plan limit notifications
- Improved app launch performance
- Fixed workspace and context update issues

## 0.32.0 - March 11, 2025 (General Availability)
### Added
- Implemented model picker for selecting LLM model in chat
- Introduced new `/releaseNotes` slash command for accessing release information

### Changed
- Improved focus handling with automatic switching between chat text field and file search bar
- Enhanced keyboard navigation support for file picker in chat context
- Refined instructions for granting accessibility and extension permissions
- Enhanced accessibility compliance for the chat window
- Redesigned notification and status bar menu styles for better usability

### Fixed
- Resolved compatibility issues with macOS 12/13/14
- Fixed handling of invalid workspace switch event '/'
- Corrected chat attachment file picker to respect workspace scope
- Improved icon display consistency across different themes
- Added support for previously unsupported file types (.md, .txt) in attachments
- Adjusted incorrect margins in chat window UI

## 0.31.0 - February 11, 2025 (Public Preview)
### Added
- Added Copilot Chat support
- Added GitHub Freeplan support
- Implemented conversation and chat history management across multiple Xcode instances
- Introduced multi-file context support for comprehensive code understanding
- Added slash commands for specialized operations
