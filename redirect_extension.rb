# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
class RedirectExtension < Radiant::Extension
  version "0.0.1"
  description "This extensions looks for a 'redirect_url' page field and uses it to perform a 302 redirect"
  url ''


  def activate
    require 'redirect_page'
    require 'radiant-redirect-extension/page_redirect'
    SiteController.send :include, RadiantRedirectExtension::PageRedirect
  end


  def deactivate
    # remove alias_method_chain otherwise stack level too deep
    # http://blog.jayfields.com/2008/04/alternatives-for-redefining-methods.html
    SiteController.class_eval do
      alias_method :process_page, :process_page_without_redirect
    end
  end
end
