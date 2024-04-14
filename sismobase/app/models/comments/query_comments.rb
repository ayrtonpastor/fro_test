# frozen_string_literal: true

module Comments
  # ::Comments::QueryComments
  class QueryComments
    def self.all
      Comment.all
    end
  end
end
