# Read fixtures from disk: pages captured from www.arccinema.co.uk and the
# Beeston venue's site, trimmed to a few films. They keep the site's
# Windows-1252 bytes and follow the shape in api_shapes.rb.
module FixturesHelper
  private

  def home_html
    read_fixture('website/home.html')
  end

  def whats_on_html(cinema_id)
    read_fixture("website/whatson-#{cinema_id}.html")
  end

  def read_fixture(filepath)
    File.binread(File.expand_path("../../fixtures/#{filepath}", __FILE__))
  end
end
