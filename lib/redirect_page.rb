require 'radiant-redirect-extension/field_finders/rails_2_field_finder'
require 'radiant-redirect-extension/field_finders/rails_3_field_finder'

class RedirectPage < Page
  description 'A page that redirects'

  field 'redirect_url'

  DEFAULT_REDIRECT_URL_FIELD_NAME = 'redirect_url'

  def self.redirect_url_field_name
    @redirect_url_field_name ||= DEFAULT_REDIRECT_URL_FIELD_NAME
  end


  def self.redirect_url_field_name=(redirect_url_field_name)
    @redirect_url_field_name = redirect_url_field_name
  end


  def self.field_finder_class
    @field_finder_class ||= if Rails.version >= '3.0.0'
                              RadiantRedirectExtension::FieldFinders::Rails3FieldFinder
                            else
                              RadiantRedirectExtension::FieldFinders::Rails2FieldFinder
                            end
  end

  def redirect_url_field_name
    self.class.redirect_url_field_name
  end

  def redirect_url
    redirect_url_field.try(:content)
  end

  private

  def redirect_url_field
    field_finder.find(redirect_url_field_name)
  end

  def field_finder
    self.class.field_finder_class.new(self)
  end
end
