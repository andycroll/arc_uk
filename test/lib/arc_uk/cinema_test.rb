require_relative '../../test_helper'

class ArcUk::CinemaTest < Minitest::Test
  include WebsiteStubs

  IDS = %w(ARC_BEE ARC_BLA ARC_DAV ARC_GYA ARC_HUC ARC_LEW ARC_PET ARC_PRE ARC_ROT).freeze

  def setup
    stub_website
    ArcUk::Cinema.instance_variable_set(:@venues_hash, nil)
  end

  def test_reads_arccinema_co_uk
    assert_equal 'https://www.arccinema.co.uk', ArcUk::Cinema.client.base_url
  end

  def test_new_stores_upcase_string_id
    assert_equal 'ARC_BEE', ArcUk::Cinema.new('arc_bee').id
  end

  def test_all_returns_every_venue
    cinemas = ArcUk::Cinema.all

    assert(cinemas.all? { |cinema| cinema.instance_of?(ArcUk::Cinema) })
    assert_equal IDS, cinemas.map(&:id)
  end

  def test_all_reads_the_home_page_once_an_hour
    2.times { ArcUk::Cinema.all }

    assert_requested :get, HOME, times: 1
  end

  def test_name_full_name_and_slug
    cinema = ArcUk::Cinema.new('ARC_GYA')

    assert_equal 'Great Yarmouth', cinema.name
    assert_equal 'Arc Great Yarmouth', cinema.full_name
    assert_equal 'arc-great-yarmouth', cinema.slug
  end

  def test_brand
    assert_equal 'Arc', ArcUk::Cinema.new('ARC_BEE').brand
  end

  def test_url
    assert_equal 'https://beeston.arccinema.co.uk', ArcUk::Cinema.new('ARC_BEE').url
  end

  def test_adr
    expected = {
      street_address:   '2 Station Road',
      extended_address: nil,
      locality:         'Beeston',
      region:           'Nottinghamshire',
      postal_code:      'NG9 2WJ',
      country_name:     'United Kingdom'
    }

    assert_equal expected, ArcUk::Cinema.new('ARC_BEE').adr
  end

  def test_building_names_come_before_the_street
    cinema = ArcUk::Cinema.new('ARC_HUC')

    assert_equal 'The Byron', cinema.street_address
    assert_equal 'High Street', cinema.extended_address
  end

  def test_every_venue_has_a_locality_and_coordinates
    ArcUk::Cinema.all.each do |cinema|
      refute_empty cinema.locality, cinema.id
      assert_kind_of Float, cinema.latitude, cinema.id
      assert_kind_of Float, cinema.longitude, cinema.id
    end
  end

  def test_open_venues_have_a_postcode
    (IDS - %w(ARC_LEW)).each do |id|
      assert_match(/\A[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}\z/, ArcUk::Cinema.new(id).postal_code, id)
    end
  end

  def test_unknown_cinema_has_no_location
    cinema = ArcUk::Cinema.new('ARC_ZZZ')

    assert_equal '', cinema.name
    assert_nil cinema.latitude
  end
end
