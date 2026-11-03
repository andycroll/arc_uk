module ArcUk
  # Internal utility classes: Do not use
  # @api private
  module Internal
    # Sanitize and standardize film titles
    class TitleSanitizer < Cinebase::TitleSanitizer
      # @!method initialize(title)
      #   Constructor
      #   @param [String] title a film title
      #   @return [ArcUk::Internal::TitleSanitizer]

      # @!method sanitized
      #   sanitized and standardized title
      #   @return [String] sanitised title

      private

      # strings and regex to be removed
      def remove
        [
          /\s*[-–]?\s*\(?\b(?:[23]D\s+)?IMAX\b\)?/i,     # IMAX copy
          /\s*\[Infinity Vision\]/i,                     # premium screen copy
          /\s+[-–]\s+3D\z/i,                             # 3D copy
          /\s*\([^)]*\blanguages?\)/i,                   # language version
          /\s*\[?\b\d+(?:st|nd|rd|th) Anniversary\]?/i,  # anniversary re-release
          /\s+4K Restoration\b/i,                        # restoration
          /\s+[-–]\s+(?:\w+\s+)*Premiere?\z/i            # premiere, e.g. "- NFF UK Premier"
        ] + COMMON_REMOVE
      end

      # regexes and their replacements
      def replace
        {
          /RBO 20\d{2}-\d{2}: The Met Opera\s+[-–]\s+(.*)/          => 'Met Opera: ',
          /RBO 20\d{2}-\d{2}: The Royal (?:Ballet|Opera)\s+[-–]\s+(.*)/ => 'Royal Ballet and Opera: ',
          /Exhibition On Screen:\s*(.*)/i                            => 'Exhibition on Screen: '
        }.merge(COMMON_REPLACE)
      end
    end
  end
end
