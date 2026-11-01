require_relative '../../../test_helper'

class FixtureShapeTest < Minitest::Test
  include ApiShapes
  include FixturesHelper

  def test_home_page_fixture_matches_shape
    assert_home_page_shape(decoded(home_html))
  end

  def test_whats_on_fixture_matches_shape
    assert_whats_on_shape(decoded(whats_on_html('ARC_BEE')))
  end

  private

  def decoded(html)
    html.force_encoding(Encoding::Windows_1252).encode(Encoding::UTF_8)
  end
end
