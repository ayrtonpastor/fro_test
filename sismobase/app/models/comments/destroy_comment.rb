# frozen_string_literal: true

module Comments
  # ::Comments::DestroyComment
  class DestroyComment
    def initialize(comment)
      @comment = comment
    end

    def destroy
      begin
        @comment.destroy
      rescue ActiveRecord::InvalidForeignKey
        false
      end
    end
  end
end
