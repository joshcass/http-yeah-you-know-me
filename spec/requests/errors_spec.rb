require 'spec_helper'

RSpec.describe 'Errors', type: :request do
  it 'returns a 404 for an unknown route' do
    response = get('/pants')
    expect(response.code).to eq 404
  end

  it 'returns a 500 when there is an error' do
    response = get('/force_error')
    expect(response.code).to eq 500
  end
end
