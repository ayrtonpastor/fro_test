namespace :features do
  desc "Sincroniza los features obtenidos desde el endpoint externo"
  task sync: :environment do
    begin
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
    response = RestClient.get(url, { 'Content-Type' => 'application/json' })
    geo_json = JSON.parse(response)
    ::Features::Synchronizer.new(geo_json['features']).perform
    rescue RestClient::ExceptionWithResponse => e
      puts "Ocurrió un error al tratar de sincronizar los features"
    end
  end
end
