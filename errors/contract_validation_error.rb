# frozen_string_literal: true

# Exception for contract validation filure
class ContractValidationError < StandardError
  attr_reader :messages

  def initialize(messages)
    @messages = messages
    super
  end
end
