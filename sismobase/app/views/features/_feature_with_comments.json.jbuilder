json.extract! feature, :id
json.type "feature"
json.attributes feature, :external_id, :magnitude, :place, :time, :tsunami, :mag_type, :title
coordinates = { coordinates: { longitude: feature.longitude, latitude: feature.latitude } }
json.attributes do
  json.merge! coordinates
end
json.links feature, :external_url
json.comments feature.comments
