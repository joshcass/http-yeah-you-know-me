require 'spec_helper'

RSpec.describe 'Date Time', type: :request do
  it 'returns the correctly formatted date and time' do
    response = get('/datetime')
    expect(response.body).to include time_format(Time.now.localtime)
  end

  def time_format(time)
    time.strftime('%l:%M%p on %A, %B %e, %Y')
  end
end
