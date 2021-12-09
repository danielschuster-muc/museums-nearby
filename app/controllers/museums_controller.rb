require 'json'
require 'open-uri'

class MuseumsController < ApplicationController
  def index
    @lat = params[:lat] ? params[:lat].to_f : 52.494857
    @lng = params[:lng] ? params[:lng].to_f : 13.437641
    @museums = find_museums(@lat, @lng)
    @postal_codes = @museums.map do |museum|
      museum["context"][0]["text"]
    end
  end

  private

  def find_museums(lat, lng)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museums.json?lat=#{lat}&lng=#{lng}&access_token=#{ENV['MAPBOX_API_KEY']}"
    url_serialized = URI.parse(url).open.read
    JSON.parse(url_serialized)["features"]
  end
end
