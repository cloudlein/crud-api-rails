# frozen_string_literal: true

# Pagy v43+ uses a new modular API. No more Pagy::Backend.
# Require only what you need.

require "pagy/classes/request"              # Pagy::Request
require "pagy/toolbox/paginators/offset"   # Pagy::OffsetPaginator
