# frozen_string_literal: true

module Comments
  # ::Comments::CreateComment
  class CreateComment
    def initialize(params, options = {})
      @params = params
    end

    def save
      @comment = Comment.new @params
      @comment.save
      @comment
    end
  end
end
