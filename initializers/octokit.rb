# frozen_string_literal: true

require 'octokit'

Octokit.configure do |c|
  c.api_endpoint = ENV.fetch('GITHUB_API_ENDPOINT', 'https://api.github.com/')
  c.connection_options = {
    request: {
      open_timeout: ENV.fetch('GITHUB_API_OPEN_TIMEOUT', 2),
      timeout: ENV.fetch('GITHUB_API_TIMEOUT', 2)
    }
  }
end
