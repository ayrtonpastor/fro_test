# frozen_string_literal: true

module Features
  # ::Features::Synchronizer
  class Synchronizer
    # Inicializa sincronizador de features
    def initialize(features_json)
      @features_json = features_json
      @response = { succeeded: 0, failures: 0 }
    end

    # [Comments] Migra los registros de documentos informativos recibidos de CTv1 a CTv2
    # [Modified by] Ayrton PC
    # [Last modified] 2024-02-28
    def perform
      sync_features
      @response
    end

    private

    def sync_features
      @response[:succeeded] = @features_json.select { |feature_json| sync_feature(feature_json) }.size
      @response[:failures] = @features_json.size - @response[:succeeded]
    end

    def sync_feature(feature_json)
      feature = Feature.find_by_external_id(feature_json['id'])
      return false if feature

      feature = Feature.creator.new(feature_params(feature_json)).save
      feature.persisted?
    end

    def feature_params(feature_json)
      {
        external_id: feature_json['id'],
        magnitude: feature_json['properties']['mag'],
        place: feature_json['properties']['place'],
        time: feature_json['properties']['time'].blank? ? '' : DateTime.strptime(feature_json['properties']['time'].to_s, '%Q').to_s,
        tsunami: feature_json['properties']['tsunami'] == 1,
        mag_type: feature_json['properties']['magType'],
        title: feature_json['properties']['title'],
        longitude: feature_json['geometry']['coordinates'][0],
        latitude: feature_json['geometry']['coordinates'][1],
        external_url: feature_json['properties']['url']
      }
    end
  end
end
