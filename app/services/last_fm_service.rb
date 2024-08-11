class LastFmService
  def fetch_artist_data(artist_name)
    response = self.class.get_url("?method=artist.getinfo&artist=#{artist_name}", { format: "json" })
    if response[:artist]
      artist_data = response[:artist]
      {
        name: artist_data[:name],
        image: artist_data[:image][1][:"#text"], # Medium size image
        bio: artist_data[:bio][:content]
      }
    else
      nil
    end
  end

  def fetch_album_data(artist_name, album_name)
    response = self.class.get_url("?method=album.getinfo&artist=#{artist_name}&album=#{album_name}", { format: "json" })
    if response[:album]
      album_data = response[:album]
      {
        name: album_data[:name],
        artist: album_data[:artist],
        image: album_data[:image][2][:'#text'], # Large size image
        tracks: album_data[:tracks][:track].map { |track| { name: track[:name], mbid: track[:mbid] } } # maps name and mbid for each track
      }
    else
      nil
    end
  end

  private

  def self.conn
    Faraday.new(url: 'http://ws.audioscrobbler.com/2.0/') do |faraday|
      faraday.params[:api_key] = Rails.application.credentials.last_fm[:api_key]
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end
