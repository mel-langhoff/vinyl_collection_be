class MusicBrainzService
  def self.fetch_song_data(recording_mbid)
    get_url("recording/#{recording_mbid}")
  end

  private 

  def self.conn
    Faraday.new(url: 'https://musicbrainz.org/ws/2/') do |faraday|
      faraday.headers['User-Agent'] = 'MelLanghoffVinylsAPI/1.0 (hello@mel-langhoff.com)'
      faraday.params[:fmt] = 'json'
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end