require 'spec_helper'

RSpec.describe 'Shutdown', type: :request do
  it 'returns the total request count' do
    response = get('/shutdown')
    expect(response.body).to include 'Total Requests: 1'
  end

  it 'shuts down the server' do
    get('/shutdown')
    expect { get('/shutdown') }.to raise_error Errno::ECONNREFUSED
  end
end
