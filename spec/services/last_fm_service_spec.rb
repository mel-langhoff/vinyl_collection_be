require 'rails_helper'

RSpec.describe 'Last.fm Service' do

  describe '#fetch_artist_data' do
    it 'returns artist data' do
      VCR.use_cassette('fetch_artist_data') do
        artist = "The Beatles"
        search = LastFmService.fetch_artist_data(artist)

        expect(search[:name]).to eq("The Beatles")
        expect(search[:image]).to eq("https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png") 
        expect(search[:bio]).to include("Liverpool")
      end
    end
  end

  describe '#fetch_album_data' do
    it 'returns album data' do
      VCR.use_cassette('fetch_album_data') do
        album = "The Chronic"
        artist = "Dr. Dre"
        search = LastFmService.fetch_album_data(artist, album)

        expect(search[:name]).to eq("The Chronic")
        expect(search[:artist]).to eq("Dr. Dre")
        expect(search[:image]).to eq("https://lastfm.freetls.fastly.net/i/u/174s/6d49060026f44d69cd67a7cffa6e3092.png")
        expect(search[:tracks]).to be_a Array
      end
    end
  end
end