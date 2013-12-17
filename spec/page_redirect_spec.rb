require 'spec_helper'

require 'active_support/core_ext'
require 'radiant-redirect-extension/page_redirect'

describe RadiantRedirectExtension::PageRedirect do

  before do
    class SiteController
      def process_page(page)
      end
    end
  end

  after do
    Object.send(:remove_const, 'SiteController')
  end

  context 'when the site controller is extended' do
    before do
      SiteController.send :include, RadiantRedirectExtension::PageRedirect
    end

    subject(:site_controller) { SiteController.new }

    context 'when the redirect_url_field_name is set' do
      before do
        SiteController.redirect_url_field_name = 'test_redirect_url_field_name'
      end

      its(:redirect_url_field_name) { should == 'test_redirect_url_field_name' }

      context 'when processing a page' do
        before do
          site_controller.stub(:redirect_to)
          site_controller.process_page(page)
        end

        let(:fields) { [] }
        let(:page) { double('Page', :fields => fields) }

        context 'if the page has no redirect url field' do
          let(:fields) { [double('Field', :name => 'some_field', :content => 'some field content')] }
          it { should_not have_received(:redirect_to) }
        end

        context 'if the page has a redirect url field' do
          context 'whose content is blank' do
            let(:fields) { [double('Field', :name => 'test_redirect_url_field_name', :content => '')] }
            it { should_not have_received(:redirect_to) }
          end

          context 'whose content is not blank' do
            let(:fields) { [double('Field', :name => 'test_redirect_url_field_name', :content => 'redirect_url')] }
            it { should have_received(:redirect_to).with('redirect_url') }
          end
        end

      end
    end
  end

end