require 'spec_helper'

RSpec.describe 'Hello World', type: :request do
  it 'returns hello world!' do
    response = get('/hello_world')
    expect(response.body).to eq 'Hello World (0)'
  end
end
