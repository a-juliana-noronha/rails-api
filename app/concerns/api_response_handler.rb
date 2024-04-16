# frozen_string_literal: true

module ApiResponseHandler
  extend ActiveSupport::Concern

  def json_response(options = {}, status = 500)
    render json: JsonResponse.new(options), status: status
  end

  def render_error_response(error, status = 422)
    json_response({
                    error: error,
                  }, status)
  end

  def render_success_response(data: {}, status: 200, meta: {})
    json_response({
                    data: data,
                  }, status)
  end
  
  # will be used for paginations
  def meta_attributes(collection, extra_meta = {})
    return [] if collection.blank?

    {
      pagination: {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
    }.merge(extra_meta)
  end
end