require 'spec_helper'

RSpec.describe 'Game', type: :request do
  describe '/start_game' do
    it 'starts the game' do
      response = post('/start_game', headers: { 'Content-Type' => 'text/html' })
      expect(response.body).to include 'Good luck!'
    end

    it 'returns a 403 if a game is already in progress' do
      post('/start_game', headers: { 'Content-Type' => 'text/html' })
      post('/game', headers: { 'Content-Type' => 'text/html' }, body:  '1' )
      response = post('/start_game', headers: { 'Content-Type' => 'text/html' })
      expect(response.forbidden?).to be true
    end
  end

  describe '/game GET' do
    it 'returns the game status' do
      post('/start_game', headers: { 'Content-Type' => 'text/html' })
      response = get('/game')
      expect(response.body).to include 'Guess count: 0'
    end
  end

  describe '/game POST' do
    it 'records the guess and redirects to the game status' do
      post('/start_game', headers: { 'Content-Type' => 'text/html' })
      response = post('/game', headers: { 'Content-Type' => 'text/html' }, body:  '1' )
      expect(response.body).to include 'Guess count: 1'
      expect(response.body).to include 'Current guess is'
    end
  end
end
