require_relative '../../../test_helper'

class ArcUk::Internal::TitleSanitizerTest < Minitest::Test
  def test_plain_titles_are_unchanged
    assert_sanitized 'Everest: The Other Side', 'Everest: The Other Side'
  end

  def test_imax_copies
    assert_sanitized 'Dune: Part Three', 'Dune: Part Three -2D IMAX'
    assert_sanitized 'THE HUNGER GAMES: SUNRISE ON THE REAPING', 'THE HUNGER GAMES: SUNRISE ON THE REAPING – IMAX'
    assert_sanitized 'Street fighter', 'Street fighter (IMAX)'
    assert_sanitized 'GODZILLA MINUS ZERO', 'GODZILLA MINUS ZERO IMAX'
    assert_sanitized 'George Michael: The Faith Tour', 'George Michael: The Faith Tour - IMAX'
    assert_sanitized 'Ramayana: Rise of a Legend', 'Ramayana: Rise of a Legend 3d IMAX (Hindi)'
  end

  def test_3d_and_infinity_vision_copies
    assert_sanitized 'Avengers: Doomsday', 'Avengers: Doomsday 3D'
    assert_sanitized 'THE HUNGER GAMES: SUNRISE ON THE REAPING', 'THE HUNGER GAMES: SUNRISE ON THE REAPING – 3D'
    assert_sanitized 'Avengers: Doomsday', 'Avengers: Doomsday [Infinity Vision]'
  end

  def test_language_versions
    assert_sanitized 'Comédie Française', 'Comédie Française (French language)'
    assert_sanitized 'NAZA', 'NAZA (Hebrew and English languages)'
    assert_sanitized 'JAK ZYC ZEBY NIE ZWARIOWAC', 'JAK ZYC ZEBY NIE ZWARIOWAC (Polish)'
  end

  def test_anniversaries_and_restorations
    assert_sanitized 'SCREAM', 'SCREAM [30th ANNIVERSARY]'
    assert_sanitized 'V For Vendetta', 'V For Vendetta 20th Anniversary'
    assert_sanitized 'Rocky', 'Rocky 50th Anniversary 4K'
    assert_sanitized 'DRACULA', 'DRACULA 4K RESTORATION'
  end

  def test_royal_ballet_and_opera_seasons
    assert_sanitized 'Royal Ballet and Opera: Swan Lake', 'RBO 2026-27: The Royal Ballet – Swan Lake'
    assert_sanitized 'Royal Ballet and Opera: Tosca', 'RBO 2026-27: The Royal Opera – Tosca'
    assert_sanitized 'Met Opera: La Fanciulla Del West', 'RBO 2026-27: The Met Opera – La Fanciulla Del West'
  end

  def test_exhibition_on_screen
    assert_sanitized 'Exhibition on Screen: Monet', 'Exhibition On Screen: Monet'
  end

  private

  def assert_sanitized(expected, title)
    assert_equal expected, ArcUk::Internal::TitleSanitizer.new(title).sanitized
  end
end
