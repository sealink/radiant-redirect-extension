module RadiantRedirectExtension
  module FieldFinders
    class Rails2FieldFinder
      attr_reader :page

      def initialize(page)
        @page = page
      end


      def find(field_name)
        page.fields.first(:conditions => {:name => field_name })
      end
    end
  end
end