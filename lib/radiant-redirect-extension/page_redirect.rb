module RadiantRedirectExtension
  module PageRedirect
    def self.included(base)
      base.class_eval do
        alias_method_chain :process_page, :redirect
      end
    end


    def process_page_with_redirect(page)
      redirect_url = page.redirect_url if page.is_a?(RedirectPage)
      if redirect_url.blank?
        return process_page_without_redirect(page)
      end

      redirect_to redirect_url
    end
  end
end
