module ArcUk
  # The object representing a cinema on the Arc Cinema website
  class Cinema < Cinebase::A1web::Cinema
    # @!attribute [r] id
    #   @return [String] the A1Web site code of the cinema, e.g. 'ARC_BEE'

    # @!method initialize(id)
    #   @param [String] id the cinema id, e.g. 'ARC_BEE' or 'arc_bee'
    #   @return [ArcUk::Cinema]

    # @!method self.all
    #   Return basic cinema information for all cinemas
    #   @return [Array<ArcUk::Cinema>]
    #   @example
    #     ArcUk::Cinema.all
    #     #=> [<ArcUk::Cinema>, <ArcUk::Cinema>, ...]

    # @!method adr
    #   Address of the cinema
    #   @return [Hash] contains :street_address, :extended_address,
    #   :locality, :region, :postal_code, :country_name
    #   @example
    #     cinema = ArcUk::Cinema.new('ARC_BEE')
    #     cinema.adr
    #     #=> {
    #           street_address:   '2 Station Road',
    #           extended_address: nil,
    #           locality:         'Beeston',
    #           region:           'Nottinghamshire',
    #           postal_code:      'NG9 2WJ',
    #           country_name:     'United Kingdom'
    #         }
    #   @note Uses method naming as at http://microformats.org/wiki/adr

    # @!method latitude
    #   @return [Float, nil]

    # @!method longitude
    #   @return [Float, nil]

    # @!method name
    #   The name of the cinema
    #   @return [String]
    #   @example
    #     ArcUk::Cinema.new('ARC_BEE').name
    #     #=> 'Beeston'

    # @!method url
    #   The url of the cinema's own site
    #   @return [String]
    #   @example
    #     ArcUk::Cinema.new('ARC_BEE').url
    #     #=> 'https://beeston.arccinema.co.uk'

    # Addresses from each venue's cinema info page, coordinates from
    # OpenStreetMap. Lewisham has not opened and has no info page yet.
    LOCATIONS = {
      'ARC_BEE' => {
        street_address: '2 Station Road', locality: 'Beeston', region: 'Nottinghamshire',
        postal_code: 'NG9 2WJ', latitude: 52.9258593, longitude: -1.2146110
      },
      'ARC_BLA' => {
        street_address: 'Houndshill Shopping Centre', extended_address: 'Coronation Street',
        locality: 'Blackpool', region: 'Lancashire', postal_code: 'FY1 4EN',
        latitude: 53.8163115, longitude: -3.0524611
      },
      'ARC_DAV' => {
        street_address: 'Mulberry Place', locality: 'Daventry', region: 'Northamptonshire',
        postal_code: 'NN11 4GH', latitude: 52.2588468, longitude: -1.1622101
      },
      'ARC_GYA' => {
        street_address: 'The Royalty', extended_address: 'Marine Parade', locality: 'Great Yarmouth',
        region: 'Norfolk', postal_code: 'NR30 2DL', latitude: 52.6093399, longitude: 1.7370726
      },
      'ARC_HUC' => {
        street_address: 'The Byron', extended_address: 'High Street', locality: 'Hucknall',
        region: 'Nottinghamshire', postal_code: 'NG15 7HJ', latitude: 53.0369694, longitude: -1.2008227
      },
      'ARC_LEW' => {
        street_address: 'The Filigree', extended_address: 'Lewisham High Street', locality: 'London',
        latitude: 51.4642160, longitude: -0.0118448
      },
      'ARC_PET' => {
        street_address: '63 Marischal Street', locality: 'Peterhead', region: 'Aberdeenshire',
        postal_code: 'AB42 1PR', latitude: 57.5049827, longitude: -1.7804212
      },
      'ARC_PRE' => {
        street_address: 'Animate', extended_address: 'Tenterfield Street', locality: 'Preston',
        region: 'Lancashire', postal_code: 'PR1 2BL', latitude: 53.7609122, longitude: -2.6993912
      },
      'ARC_ROT' => {
        street_address: 'Forge Island', extended_address: 'Bridge Street', locality: 'Rotherham',
        region: 'South Yorkshire', postal_code: 'S60 1QJ', latitude: 53.4307952, longitude: -1.3599775
      }
    }.freeze

    # @return [String]
    def self.website
      'https://www.arccinema.co.uk'.freeze
    end

    # @api private
    def self.locations
      LOCATIONS
    end

    # Brand of the cinema
    # @return [String] which will always be 'Arc'
    def brand
      'Arc'.freeze
    end
  end
end
