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
end
