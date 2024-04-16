# frozen_string_literal: true

# For format json data
class JsonResponse
  attr_reader :data, :error

  def initialize(options = {})
    # @message = options[:message] || ''
    @data = options[:data] || []
    # @meta = options[:meta] || []
    @error = options[:error] || []
  end

  def as_json(*)
    {
      # message: @message,
      data: @data,
      # meta: @meta,
      error: @error
    }
  end
end