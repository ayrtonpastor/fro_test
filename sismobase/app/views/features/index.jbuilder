json.data @features, partial: "features/feature", as: :feature
pagination = { current_page: @current_page, total: @total, per_page: @per_page }
json.pagination do
  json.merge! pagination
end
