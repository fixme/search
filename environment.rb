# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

require 'sinatra/base'
require 'sinatra/namespace'
require 'dry-validation'

require_relative 'initializers/octokit'
require_relative 'initializers/cache'
require_relative 'contracts/repositories_contract'
require_relative 'errors/contract_validation_error'
