require 'rails_helper'

RSpec.describe 'Vinyl Facade', :vcr do
  before :each do
    @artist = "Dr. Dre"
    @album = "The Chronic"
    @recording_mbid ="2fcb5bc5-2a28-4b4e-afe5-22a102ee7384" # Xxpolsive by Dr Dre
    @vinyl_facade = VinylFacade.new(@artist, @album, @recording_mbid)
  end
  it "exists" do
    expect(@vinyl_facade).to be_an_instance_of VinylFacade
  end

  it "has attributes" do
    expect(@vinyl_facade.artist).to eq(@artist)
    expect(@vinyl_facade.album).to eq(@album)
    expect(@vinyl_facade.recording_mbid).to eq(@recording_mbid)
  end

  it "#artist_data" do
    VCR.use_cassette('fetch_artist_data') do
      artist_data = @vinyl_facade.artist_data

      expect(artist_data).to be_a Hash
      expect(artist_data[:name]).to eq("Dr. Dre")
      expect(artist_data[:bio]).to be_a String
    end
  end

  it "#album_data" do
    VCR.use_cassette('fetch_album_data') do
      album_data = @vinyl_facade.album_data

      expect(album_data).to be_a Hash
      expect(album_data[:name]).to eq("The Chronic")
      expect(album_data[:artist]).to eq("Dr. Dre")
      expect(album_data[:tracks]).to be_an Array
    end
  end

  it "#song_data" do
    song_data = @vinyl_facade.song_data

    expect(song_data).to be_a Hash
    expect(song_data[:title]).to eq("Xxplosive")
    expect(song_data[:artist]).to be_a String
  end
end