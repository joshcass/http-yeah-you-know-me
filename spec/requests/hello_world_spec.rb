require 'spec_helper'

RSpec.describe 'Hello World', type: :request do
  it 'returns hello world!' do
    response = get('/hello')
    expect(response.body).to include 'Hello World! (0)'
  end

  it 'increments the count with each request' do
    response = get('/hello')
    response = get('/hello')
    response = get('/hello')
    expect(response.body).to include 'Hello World! (2)'
  end
end
