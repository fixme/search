# frozen_string_literal: true

# Null storage to bypass caching for testing and development
class NullStorage
  def write(*); end
  def read(*); end
end
