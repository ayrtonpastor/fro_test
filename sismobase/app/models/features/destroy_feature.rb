# frozen_string_literal: true

module Features
  # ::Features::DestroyFeature
  class DestroyFeature
    def initialize(feature)
      @feature = feature
    end

    def destroy
      begin
        @feature.destroy
      rescue ActiveRecord::InvalidForeignKey
        false
      end
    end
  end
end
