# frozen_string_literal: true

module Features
  # ::Features::CreateFeature
  class CreateFeature
    def initialize(params, options = {})
      @params = params
    end

    def save
      @feature = Feature.new @params
      @feature.save
      @feature
    end
  end
end
