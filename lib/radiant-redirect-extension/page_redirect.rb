module RadiantRedirectExtension
  module PageRedirect

    DEFAULT_REDIRECT_PAGE_LAYOUT_NAME = 'redirect_page_fs'
    DEFAULT_REDIRECT_URL_FIELD_NAME = 'redirect_url'


    def self.included(base)
      base.class_eval do
        alias_method_chain :process_page, :redirect
        extend ClassMethods
      end
    end


    module ClassMethods

      def redirect_page_layout_name
        @redirect_page_layout_name ||= DEFAULT_REDIRECT_PAGE_LAYOUT_NAME
      end


      def redirect_page_layout_name=(redirect_page_layout_name)
        @redirect_page_layout_name = redirect_page_layout_name
      end


      def redirect_url_field_name
        @redirect_url_field_name ||= DEFAULT_REDIRECT_URL_FIELD_NAME
      end


      def redirect_url_field_name=(redirect_url_field_name)
        @redirect_url_field_name = redirect_url_field_name
      end

    end


    def redirect_page_layout_name
      self.class.redirect_page_layout_name
    end


    def redirect_url_field_name
      self.class.redirect_url_field_name
    end


    def process_page_with_redirect(page)
      return process_page_without_redirect(page) unless page.layout.name == redirect_page_layout_name

      redirect_url_field = page.fields.find { |field| field.name == redirect_url_field_name }
      redirect_url = redirect_url_field && redirect_url_field.content

      return process_page_without_redirect(page) if redirect_url.blank?

      redirect_to redirect_url
    end

  end
end
