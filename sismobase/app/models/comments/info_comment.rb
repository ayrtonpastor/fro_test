# frozen_string_literal: true

module Comments
  # ::Comments::InfoComment
  class InfoComment
    def initialize(comment)
      @comment = comment
    end

    def basic_info_json
      @comment.as_json(only: %i[id])
    end
  end
end
