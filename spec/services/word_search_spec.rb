require 'spec_helper'

RSpec.describe Application::Services::WordSearch do
  describe '#known?' do
    it 'returns true if the word is known' do
      expect(subject.known?('pizza')).to be true
    end

    it 'returns false if the word is unknown' do
      expect(subject.known?('asdf')).to be false
    end
  end

  describe '#possible_matches' do
    it 'returns one word if it is an exact match' do
      expect(subject.possible_matches('pizza')).to eq ['pizza']
    end

    it 'returns multiple results if it is a partial match' do
      expect(subject.possible_matches('pizz'))
        .to match_array %w[pizza pizzeria pizzicato pizzle spizzerinctum]
    end
  end
end
