# frozen_string_literal: true

require 'spec_helper'
require_relative '../../application'

RSpec.describe '/repositories', type: :request, vcr: { cassette_name: 'repositories', record: :new_episodes } do
  def app
    Application
  end

  context 'with proper search parameters' do
    before do
      get '/repositories', query: 'golang rest api',
                           sort: 'name',
                           order: 'desc',
                           page: 2,
                           per_page: 5
    end

    it 'response with success' do
      expect(last_response).to be_successful
    end

    %w[
      conradwt/zero-to-restful-api-using-buffalo
      apostrophedottilde/zenfighter-api
      bharathkuppala/Zendesk-RestAPI-Golang
      eikoshelev/zavhoz
      uthark/yttrium
    ].each do |name|
      it "includes #{name} repository" do
        expect(last_response.body).to include name
      end
    end
  end

  shared_examples 'error message' do |message:, params:|
    before do
      get '/repositories', params
    end

    it 'renders error message' do
      expect(last_response.body).to include message
    end
  end

  it_behaves_like 'error message', message: 'query is missing',
                                   params: {}

  it_behaves_like 'error message', message: 'page must be an integer',
                                   params: {
                                     query: 'golang rest api',
                                     page: 'WRONG'
                                   }

  it_behaves_like 'error message', message: 'per_page must be an integer',
                                   params: {
                                     query: 'golang rest api',
                                     per_page: 'WRONG'
                                   }

  it_behaves_like 'error message', message: 'order must be one of: asc, desc',
                                   params: {
                                     query: 'golang rest api',
                                     order: 'WRONG'
                                   }

  it_behaves_like 'error message', message: 'Only the first 1000 search results are available',
                                   params: {
                                     query: 'golang rest api',
                                     page: 1000,
                                     per_page: 5
                                   }
end
