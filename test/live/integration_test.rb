require_relative 'live_helper'

class LiveIntegrationTest < Minitest::Test
  def test_cinemas_and_their_performances
    cinemas = ArcUk::Cinema.all

    assert(cinemas.all? { |cinema| cinema.instance_of?(ArcUk::Cinema) })
    assert_operator cinemas.size, :>=, 8
    assert_empty cinemas.map(&:id) - ArcUk::Cinema::LOCATIONS.keys

    beeston = cinemas.detect { |cinema| cinema.id == 'ARC_BEE' }
    assert_equal 'Beeston', beeston.name

    today = Date.today
    performances = ArcUk::Performance.at('ARC_BEE', from: today, to: today + 365)

    assert(performances.all? { |p| p.instance_of?(ArcUk::Performance) })
    assert_operator performances.count, :>, 50
    assert_operator performances.map(&:showing_on).max, :>, today + 14
    assert(performances.all? { |p| p.booking_url.match?(ApiShapes::BOOKING_URL) })
  end
end
