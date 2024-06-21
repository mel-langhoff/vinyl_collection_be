require 'csv'

# Import artists
CSV.foreach(Rails.root.join('db', 'data', 'artists.csv'), headers: true) do |row|
  artist = Artist.new(
    name: row['name'],
    category: row['category']
  )
  artist.save
end

# Import albums
CSV.foreach(Rails.root.join('db', 'data', 'albums.csv'), headers: true) do |row|
  album = Album.new(
    title: row['title'],
    notes: row['notes'],
    artist_id: row['artist_id']
  )
  album.save
end
