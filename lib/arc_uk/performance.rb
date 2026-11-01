module ArcUk
  # A single screening of a film on the Arc Cinema website
  class Performance < Cinebase::A1web::Performance
    # @!attribute [r] booking_url
    #   @return [String] the booking URL on the cinema website
    # @!attribute [r] cinema_name
    #   @return [String] the cinema name
    # @!attribute [r] cinema_id
    #   @return [String] the cinema id
    # @!attribute [r] dimension
    #   @return [String] 2d or 3d
    # @!attribute [r] film_name
    #   @return [String] the film name

    # @!method initialize(options)
    #   @param [Hash] options options hash
    #   @option options [String] :booking_url (nil) buying url for the screening
    #   @option options [String] :cinema_name name of the cinema
    #   @option options [String] :cinema_id website id of the cinema
    #   @option options [String] :dimension ('2d') dimension of the screening
    #   @option options [Cinebase::Festival] :festival (nil) festival edition
    #   @option options [String] :film_name name of the film
    #   @option options [Integer] :film_year (nil) year from the film's title
    #   @option options [String] :language (nil) audio language, e.g. 'Polish'
    #   @option options [Time] :starting_at listed start time of the performance

    # @!method self.at(cinema_id, from: Date.today, to: from + 13)
    #   Performances within an inclusive range of showing dates, from one
    #   request: the venue's what's on page holds every advertised date.
    #   @param [String] cinema_id id of the cinema, e.g. 'ARC_BEE'
    #   @param [Date] from first date (defaults to today in London)
    #   @param [Date] to last date (defaults to 13 days after from)
    #   @return [Array<ArcUk::Performance>]

    # @!method showing_on
    #   The date of the screening
    #   @return [Date]

    # @!method starting_at
    #   UTC time of the screening
    #   @return [Time]

    # @!method variant
    #   The kinds of screening (arts, baby, hypersense, imax, kids ...)
    #   @return <Array[String]>

    # Arc's showtime icons, beyond those A1Web chains share. Hypersense and
    # Infinity Vision are Arc's premium screens.
    VARIANTS = {
      'Arc Events' => 'arts',
      'Hypersense' => 'hypersense',
      'Infinity Vision' => 'infinity_vision'
    }.freeze

    # @api private
    def self.cinema_class
      Cinema
    end

    # @api private
    def self.title_sanitizer
      Internal::TitleSanitizer
    end

    # @api private
    def self.variants
      super.merge(VARIANTS)
    end
  end
end
