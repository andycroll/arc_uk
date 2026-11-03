require_relative '../../test_helper'

class ArcUk::PerformanceTest < Minitest::Test
  include WebsiteStubs

  DATE = Date.new(2026, 11, 1)

  def setup
    stub_website
    ArcUk::Cinema.instance_variable_set(:@venues_hash, nil)
  end

  def test_at_returns_performances_in_time_order
    performances = performances_at('ARC_BEE')

    assert(performances.all? { |p| p.instance_of?(ArcUk::Performance) })
    assert_equal 41, performances.count
    assert_equal performances.map(&:starting_at).sort, performances.map(&:starting_at)
  end

  def test_at_reads_every_date_from_one_page
    performances_at('arc_bee')

    assert_requested :get, "#{BEESTON}/whatson", times: 1
  end

  def test_at_keeps_to_the_range
    assert_equal 14, ArcUk::Performance.at('ARC_BEE', from: DATE, to: DATE + 1).count
  end

  def test_at_sets_cinema_details
    performances = performances_at('ARC_BEE')

    assert_equal ['ARC_BEE'], performances.map(&:cinema_id).uniq
    assert_equal ['Beeston'], performances.map(&:cinema_name).uniq
  end

  def test_at_parses_first_performance
    performance = performances_at('ARC_BEE').detect { |p| p.film_name == 'Clayface' }

    assert_nil performance.film_year
    assert_equal Time.utc(2026, 11, 1, 16, 0), performance.starting_at
    assert_equal '2d', performance.dimension
    assert_nil performance.language
    assert_equal %w(hypersense), performance.variant
    assert_equal 'https://beeston.admit-one.co.uk/tickets/?perfCode=86104', performance.booking_url
  end

  def test_summer_times_are_utc
    performance = performances_at('ARC_BEE').last

    assert_equal 'Swan Lake', performance.film_name
    assert_equal Cinebase::Event.new(name: 'Royal Ballet and Opera'), performance.event
    assert_equal Time.utc(2027, 4, 22, 18, 15), performance.starting_at
    assert_equal %w(arts), performance.variant
  end

  def test_3d_copies_are_the_same_film
    performances = on(Date.new(2026, 12, 16)).select { |p| p.dimension == '3d' }

    assert_equal 3, performances.count
    assert_equal ['Avengers: Doomsday'], performances.map(&:film_name).uniq
  end

  def test_infinity_vision_copies_are_the_same_film
    performances = on(Date.new(2026, 12, 16)).select { |p| p.variant.include?('infinity_vision') }

    assert_equal 4, performances.count
    assert_equal ['Avengers: Doomsday'], performances.map(&:film_name).uniq
  end

  def test_accessible_and_audience_screenings
    variants = performances_at('ARC_BEE').flat_map(&:variant).tally

    assert_equal 1, variants['baby']
    assert_equal 1, variants['relaxed']
    assert_equal 2, variants['senior']
    assert_equal 1, variants['subtitled']
  end

  def test_language_from_the_title
    performance = performances_at('ARC_BEE').detect { |p| p.language == 'Polish' }

    assert_equal 'Jak Zyc Zeby Nie Zwariowac', performance.film_name
  end

  def test_nff_is_the_nottingham_film_festival
    performance = ArcUk::Performance.new(
      cinema_id: 'ARC_BEE',
      cinema_name: 'Beeston',
      film_name: 'Robin Hood Film Award Nominees Screening',
      starting_at: Time.utc(2026, 11, 7, 19),
      title: 'NFF- Robin Hood Film Award Nominees Screening'
    )

    assert_equal Cinebase::Festival.new(name: 'Nottingham Film Festival', year: 2026), performance.festival
  end

  private

  def performances_at(cinema_id)
    ArcUk::Performance.at(cinema_id, from: DATE, to: DATE + 365)
  end

  def on(date)
    ArcUk::Performance.at('ARC_BEE', from: date, to: date)
  end
end
