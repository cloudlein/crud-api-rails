# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  private

  def paginate(collection)
    pagy_request = Pagy::Request.new(request: request, limit: (params[:limit] || 10).to_i)
    Pagy::OffsetPaginator.paginate(collection, request: pagy_request)
  end
end
