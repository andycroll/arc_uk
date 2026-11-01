require_relative 'fixtures_helper'

# Serve the fixtures in place of arccinema.co.uk
module WebsiteStubs
  include FixturesHelper

  HOME = 'https://www.arccinema.co.uk/'.freeze
  BEESTON = 'https://beeston.arccinema.co.uk'.freeze

  private

  def stub_website
    stub_request(:get, HOME).to_return(status: 200, body: home_html)
    stub_request(:get, "#{BEESTON}/whatson").to_return(status: 200, body: whats_on_html('ARC_BEE'))
  end
end
