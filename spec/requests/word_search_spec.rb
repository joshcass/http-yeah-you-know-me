require 'spec_helper'

RSpec.describe 'Word Search', type: :request do
  it 'returns postiive if the word is known' do
    response = get('/word_search', query: { word: 'pizza' })
    expect(response.body).to include 'pizza is a known word'
  end

  it 'returns negative if the word is unknown' do
    response = get('/word_search', query: { word: 'asdf' })
    expect(response.body).to include 'asdf is not a known word'
  end

  describe 'application/json requests' do
    it 'returns correct json if the word is found and exact match' do
      response = get('/word_search',
                     headers: { 'Accept' => 'application/json' },
                     query: { word: 'pizza' })

      expect(JSON.parse(response.body)).to eq({ 'word' => 'pizza', 'is_word' => true })
    end

    it 'returns the correct json if the word is a fuzzy match' do
      response = get('/word_search',
                     headers: { 'Accept' => 'application/json' },
                     query: { word: 'pizz' })

      expect(JSON.parse(response.body))
        .to eq({ 'word' => 'pizz',
                 'is_word' => true,
                 'possible_matches' => %w[pizza pizzeria pizzicato pizzle spizzerinctum] })
    end

    it 'returns the correct json if the word is not a match' do
      response = get('/word_search',
                     headers: { 'Accept' => 'application/json' },
                     query: { word: 'asdf' })

      expect(JSON.parse(response.body)).to eq({ 'word' => 'asdf', 'is_word' => false })
    end
  end
end
