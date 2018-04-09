require 'spec_helper'

RSpec.describe Application::Services::Game do
  let(:game) { described_class.new.tap { |game| game.start! } }

  describe '#start!' do
    it 'sets up a new game' do
      new_game = subject
      new_game.start!
      expect(new_game.guess_count).to eq 0
      expect(new_game.current_guess?).to be false
    end
  end

  describe '#guess!' do
    it 'guess!s the game with a new guess' do
      game.guess!(3)
      expect(game.current_guess?).to be true
    end

    it 'increments the guess count' do
      game.guess!(3)
      expect(game.guess_count).to eq 1
    end
  end

  describe '#status' do
    before do
      allow(game).to receive(:answer) { 5 }
    end

    it 'returns the correct status if the guess is low' do
      game.guess!(4)
      expect(game.status).to eq :too_low
    end

    it 'returns the correct status if the guess it too high' do
      game.guess!(6)
      expect(game.status).to eq :too_high
    end

    it 'returns the correct status if the guess correct' do
      game.guess!(5)
      expect(game.status).to eq :correct
    end
  end

  describe '#current_game?' do
    it 'returns false if there is no guess' do
      expect(game.current_game?).to be false
    end

    it 'returns false if the current guess is correct' do
      allow(game).to receive(:answer) { 5 }
      game.guess!(5)

      expect(game.current_game?).to be false
    end

    it 'returns true if the current guess is wrong' do
      allow(game).to receive(:answer) { 5 }
      game.guess!(4)

      expect(game.current_game?).to be true
    end
  end
end
