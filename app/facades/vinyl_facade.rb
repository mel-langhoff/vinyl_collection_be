class VinylFacade
  attr_reader :artist, :album, :recording_mbid

  def initialize(artist, album, recording_mbid)
    @artist = artist
    @album = album
    @recording_mbid = recording_mbid
  end

  def artist_data
    response = LastFmService.fetch_artist_data(artist)
    format_artist_data(response)
  end

  def album_data
    response = LastFmService.fetch_album_data(artist, album)
    format_album_data(response)
  end

  def song_data
    response = MusicBrainzService.fetch_song_data(recording_mbid)
    format_song_data(response)
  end

  private

  def format_artist_data(artist_data)
    {
      name: artist_data[:name],
      image: artist_data[:image][1][:"#text"], # Medium size image
      bio: artist_data[:bio][:content]
    }
  end

  def format_album_data(album_data)
    {
      name: album_data[:name],
      artist: album_data[:artist],
      image: album_data[:image][2][:'#text'], # Large size image
      tracks: album_data[:tracks][:track].map { |track| { name: track[:name], recording_mbid: track[:recording_mbid] } } # maps name and recording_mbid for each track
    }
  end

  def format_song_data(song_data)
    {
      title: data[:title],
      artist: data[:artist_credit].map { |credit| credit[:name] }.join(', '),
      album: data[:release][:title],
      release_date: data[:release][:date],
      genre: data[:genre] || 'Unknown'
    }
  end
end