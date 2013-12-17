require 'radiant-redirect-extension/field_finders/rails_2_field_finder'
require 'radiant-redirect-extension/field_finders/rails_3_field_finder'

module RadiantRedirectExtension
  module PageRedirect

    DEFAULT_REDIRECT_URL_FIELD_NAME = 'redirect_url'


    def self.included(base)
      base.class_eval do
        alias_method_chain :process_page, :redirect
        extend ClassMethods
      end
    end


    module ClassMethods

      def redirect_url_field_name
        @redirect_url_field_name ||= DEFAULT_REDIRECT_URL_FIELD_NAME
      end


      def redirect_url_field_name=(redirect_url_field_name)
        @redirect_url_field_name = redirect_url_field_name
      end


      def field_finder_class
        @field_finder_class ||= if Rails.version >= '3.0.0'
                                  RadiantRedirectExtension::FieldFinders::Rails3FieldFinder
                                else
                                  RadiantRedirectExtension::FieldFinders::Rails2FieldFinder
                                end
      end

    end


    def redirect_url_field_name
      self.class.redirect_url_field_name
    end


    def process_page_with_redirect(page)
      redirect_url_field = field_finder_for(page).find(redirect_url_field_name)
      redirect_url = redirect_url_field && redirect_url_field.content

      return process_page_without_redirect(page) if redirect_url.blank?

      redirect_to redirect_url
    end


    private

    def field_finder_for(page)
      self.class.field_finder_class.new(page)
    end

  end
end
