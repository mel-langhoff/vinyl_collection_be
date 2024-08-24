require 'rails_helper'

RSpec.describe 'Last.fm Service' do

  describe '#fetch_song_data' do
    it 'returns song data' do
      VCR.use_cassette('fetch_song_data') do
        recording_mbid = "2fcb5bc5-2a28-4b4e-afe5-22a102ee7384" # Xxpolsive by Dr Dre
        search = MusicBrainzService.fetch_song_data(recording_mbid)

        expect(search[:title]).to eq("Xxplosive")
        expect(search[:length]).to eq(215266)
      end
    end
  end
end