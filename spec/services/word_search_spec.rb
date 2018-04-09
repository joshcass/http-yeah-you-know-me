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
end
