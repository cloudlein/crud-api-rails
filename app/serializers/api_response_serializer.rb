# frozen_string_literal: true

class ApiResponseSerializer
  def self.success(
    data: nil,
    message: "Success",
    meta: nil,
    **extra
  )
    response = {
      success: true,
      message: message,
    }

    response[:data] = data unless data.nil?
    response[:meta] = meta unless meta.nil?

    response.merge!(extra) unless extra.present?

    response
  end

end
