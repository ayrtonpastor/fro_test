class FeaturesController < ApplicationController
  before_action :verify_per_page, only: %i[index]
  before_action :set_feature, only: %i[add_comment show]

  def index
    @per_page = params[:per_page]
    @current_page = params[:page]
    @features = filtered_features.page(@current_page).per(@per_page)
    @total = filtered_features.count
  end

  def add_comment
    puts params.inspect.to_yaml
    @comment = Comment.creator.new(comment_params).save

    if @comment.persisted?
      render 'show', status: :created, location: @feature
    else
      render(json: @comment.errors, status: :unprocessable_entity)
    end
  end

  def show; end

  private

  def verify_per_page
    return if params[:per_page].to_i <= 1000

    render(json: { error: 'La cantidad de elementos por página no puede ser mayor a 1000' }, status: 400)
  end

  def filtered_features
    return Feature.all if params[:mag_type].blank?

    Feature.where(mag_type: params[:mag_type])
  end

  def set_feature
    @feature = Feature.where(id: params[:feature_id]).first
    return if @feature

    render(json: { error: 'El feature no pudo ser encontrado' }, status: 404)
  end

  def comment_params
    params[:comment] = params.merge({ feature_id: @feature.id })
    params.require(:comment).permit(:feature_id, :body)
  end

  def feature_params

  end
end
