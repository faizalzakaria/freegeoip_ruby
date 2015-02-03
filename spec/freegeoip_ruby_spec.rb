require 'spec_helper'

describe FreegeoipRuby do

  FreegeoipRuby.configure do |config|
    config.endpoint = 'https://freegeoip.net/'
    config.options = {}
  end

  describe 'Test IP' do

    it 'should donate' do
      response = FreegeoipRuby.ip_for('121.122.1.189')
      response = JSON.parse response.body
      expect(response['country_name']).to eql('Malaysia')
      expect(response['country_code']).to eql('MY')
    end

  end

  private

  def assert_acknowledgement(response)
    response['firstGivingDonationApi']['firstGivingResponse']['acknowledgement'].should eq 'Success'
  end
end
