Rails.application.routes.draw do
  get 'api/features', to: 'features#index'
  get 'api/features/:feature_id', to: 'features#show', as: 'feature'
  post 'api/features/comments/:feature_id', to: 'features#add_comment'
end
