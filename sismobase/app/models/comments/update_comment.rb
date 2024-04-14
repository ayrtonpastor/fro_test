# frozen_string_literal: true

module Comments
  # ::Comments::UpdateComment
  class UpdateComment
    def initialize(comment, params)
      @comment = comment
      @params = params
    end

    def update
      @comment.update(@params) ? true : false
    end
  end
end
