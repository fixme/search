# frozen_string_literal: true

require_relative 'environment'

# Service to search public repositories on Github
class Application < Sinatra::Base
  register Sinatra::Namespace

  set :public_folder, 'public'
  set :cache_ttl, 10

  helpers do
    def validate!(params, contract:)
      result = contract.call(params)
      raise ContractValidationError, result.errors(full: true) if result.failure?

      result
    end

    def client
      @client ||= Octokit::Client.new
    end
  end

  get '/' do
    haml 'repositories'
  end

  get '/repositories' do
    valid_params = validate!(params, contract: RepositoriesContract.new)

    response = Cache.fetch(request.fullpath, ttl: settings.cache_ttl) do
      client.search_repositories(
        valid_params['query'],
        valid_params.to_h
      )
    end

    haml :repositories, locals: {
      total: response.total_count || 0,
      has_more: response.incomplete_results || false,
      collection: response.items
    }
  rescue Octokit::Error, Faraday::TimeoutError, ContractValidationError => e
    errors = e.respond_to?(:messages) ? e.messages : [e.message]
    haml :errors, locals: { errors: errors }
  end
end
