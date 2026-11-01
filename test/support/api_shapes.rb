# The parts of Arc pages the gem reads. Checked against the trimmed fixtures
# and, in the live suite, against real pages held only in memory.
module ApiShapes
  VENUE_URL = %r{\Ahttps://[a-z]+\.arccinema\.co\.uk\z}
  SITE_CODE = /\AARC_[A-Z]{3}\z/
  BOOKING_URL = %r{\Ahttps://[a-z]+\.admit-one\.co\.uk/tickets/\?perfCode=\d+\z}
  SHOWTIME = %r{<a class="[^"]*perfButton[^"]*" href="([^"]*)"[^>]*>(.*?)</a>}m
  START_AND_END = %r{\d{2}:\d{2} - <small>\d{2}:\d{2}</small>}

  private

  def assert_home_page_shape(html)
    codes = html.scan(Cinebase::A1web::Client::SITE_CODES)
    refute_empty codes
    codes.each do |url, code|
      assert_match VENUE_URL, url
      assert_match SITE_CODE, code
    end
    assert_equal codes.map(&:first).sort, html.scan(Cinebase::A1web::Client::VENUE).map(&:first).uniq.sort
  end

  def assert_whats_on_shape(html)
    panels = html.scan(Cinebase::A1web::Listings::PANEL).flatten
    refute_empty panels
    panels.each { |key| assert_match(/\A\d{10}\z/, key) }
    assert_match Cinebase::A1web::Listings::FILM, html
    showtimes = html.scan(SHOWTIME)
    refute_empty showtimes
    showtimes.each do |href, button|
      assert_match BOOKING_URL, href
      assert_match START_AND_END, button
    end
  end
end
