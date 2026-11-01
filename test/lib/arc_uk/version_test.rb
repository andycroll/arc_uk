require_relative '../../test_helper'

class ArcUk::VersionTest < Minitest::Test
  def test_version_is_defined
    refute_nil ArcUk::VERSION
  end
end
