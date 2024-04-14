# frozen_string_literal: true

module Features
  # ::Features::UpdateFeature
  class UpdateFeature
    def initialize(feature, params)
      @feature = feature
      @params = params
    end

    def update
      @feature.update(@params) ? true : false
    end
  end
end
