require_relative 'live_helper'

# The home page and one venue's what's on page: two requests.
class LiveApiShapeTest < Minitest::Test
  include ApiShapes

  BEESTON = 'https://beeston.arccinema.co.uk'.freeze

  def test_pages_are_readable
    client = ArcUk::Cinema.client
    home = client.send(:get, "#{client.base_url}/")

    assert_home_page_shape(home)
    assert_whats_on_shape(client.whats_on(BEESTON))
  end
end
