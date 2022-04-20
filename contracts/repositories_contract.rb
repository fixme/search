# frozen_string_literal: true

# Params validation contract
class RepositoriesContract < Dry::Validation::Contract
  params do
    required(:query).value(:string, min_size?: 1)
    optional(:sort).value(:string)
    optional(:order).value(included_in?: %w[asc desc])
    optional(:per_page).value(:integer)
    optional(:page).value(:integer)
  end
end
