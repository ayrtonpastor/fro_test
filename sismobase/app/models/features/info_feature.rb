# frozen_string_literal: true

module Features
  # ::Features::InfoFeature
  class InfoFeature
    def initialize(feature)
      @feature = feature
    end

    def basic_info_json
      @feature.as_json(only: %i[id])
    end
  end
end
