module RadiantRedirectExtension
  module FieldFinders
    class Rails3FieldFinder
      attr_reader :page

      def initialize(page)
        @page = page
      end


      def find(field_name)
        page.fields.where(:name => field_name).first
      end
    end
  end
end