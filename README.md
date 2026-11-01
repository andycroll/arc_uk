# ArcUk

A simple gem to pull cinemas and performances from the [Arc Cinema website](https://www.arccinema.co.uk) and spit out useful formatted info.

## Installation

Add this line to your application's Gemfile:

    gem 'arc_uk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arc_uk

## Usage

The gem conforms to the API set down in the `cinebase` gem, [andycroll/cinebase](https://github.com/andycroll/cinebase), which provides a lot of useful base vocabulary and repetitive code for this series of cinema focussed gems.

Performance titles are sanitized as much as possible, removing IMAX, 3D and
Infinity Vision copies, language versions, years, anniversary restorations
and festival prefixes.

No token or setup is needed. Arc's website runs on Admit One's A1Web, and
cinebase's shared `Cinebase::A1web` support reads it. Each venue has its own
site, such as `https://beeston.arccinema.co.uk`, listed with its A1Web site
code on the Arc home page.

### Cinema

The venue list is cached for an hour. The website has no structured addresses
or coordinates, so the gem holds them: addresses from each venue's cinema info
page and coordinates from OpenStreetMap. Lewisham is listed but has not opened,
so it has no postcode and no performances yet.

``` ruby
ArcUk::Cinema.all
#=> [<ArcUk::Cinema ...>, <ArcUk::Cinema ...>, ...]

cinema = ArcUk::Cinema.new('ARC_BEE')
#=> <ArcUk::Cinema ...>

cinema.adr
#=> {
  street_address:   '2 Station Road',
  extended_address: nil,
  locality:         'Beeston',
  region:           'Nottinghamshire',
  postal_code:      'NG9 2WJ',
  country_name:     'United Kingdom'
}

cinema.brand
#=> 'Arc'

cinema.full_name
#=> 'Arc Beeston'

cinema.id
#=> 'ARC_BEE'

cinema.latitude
#=> 52.9258593

cinema.url
#=> 'https://beeston.arccinema.co.uk'
```

### Performances

`Performance.at` returns performances for an inclusive range of showing dates,
defaulting to today in London and the following 13 days. The venue's what's on
page holds every advertised date, months ahead, so any range is one request.

``` ruby
ArcUk::Performance.at('ARC_BEE', from: Date.today, to: Date.today + 2)
#=> [<ArcUk::Performance ...>, <ArcUk::Performance ...>, ...]

performance = ArcUk::Performance.at('ARC_BEE').first
#=> <ArcUk::Performance ...>

performance.film_name
#=> 'Avengers: Doomsday' # from 'Avengers: Doomsday [Infinity Vision]'

performance.language
#=> nil # e.g. 'Polish' from '(Polish)' in the title

performance.film_year
#=> nil # from the title, e.g. 1996 for 'From Dusk Till Dawn (1996)'

performance.dimension
#=> '2d'

performance.variant
#=> ['infinity_vision']

performance.subtitled?
#=> false

performance.festival
#=> nil

performance.starting_at
#=> 2026-12-16 19:00:00 UTC

performance.booking_url
#=> 'https://beeston.admit-one.co.uk/tickets/?perfCode=85000'

performance.cinema_name
#=> 'Beeston'

performance.cinema_id
#=> 'ARC_BEE'
```

Booking links go to the venue's Admit One ticketing site, which redirects to
seat selection for the performance.

Variants are `arts` (Arc Events: opera, ballet, theatre and concerts), `baby`,
`hypersense` and `infinity_vision` (Arc's premium screens), `imax`, `kids`,
`relaxed`, `senior` and `subtitled`.

## Tests

```sh
bundle exec rake          # unit tests against fixtures
bundle exec rake live     # live arccinema.co.uk
```

Fixtures in `test/fixtures` are pages captured from the Arc home page and the
Beeston venue's site, trimmed to a few films. They keep the site's
Windows-1252 bytes. `test/support/api_shapes.rb` describes the parts of the
pages the gem reads. The unit suite checks the fixtures against it and the live
suite checks real responses, held only in memory. When the website changes,
update the shape first, then the fixtures.

## Releasing

Bump the version, merge, then run the **Release Gem** workflow in GitHub
Actions. It runs the tests, tags the version and publishes the gem through
RubyGems trusted publishing.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
