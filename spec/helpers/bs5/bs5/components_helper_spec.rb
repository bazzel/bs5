# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe 'Alert' do
      subject { helper.bs5_alert(options) { 'Hello world!' } }
      let(:options) do
        { style: 'secondary',
          is_dismissable: true }
      end

      it {
        is_expected.to have_selector('.alert.alert-secondary[role="alert"]', text: 'Hello world!')
        is_expected.to have_selector('.alert.alert-dismissible.fade.show[role="alert"] button.btn-close[type="button"][data-dismiss="alert"][aria-label="Close"]')
      }
    end

    describe 'Accordion' do
      subject do
        helper.bs5_accordion(options) do |accordion|
          accordion.slot(:item, title: 'Foo', collapsed: false) { 'Lorem Ipsum' }
          accordion.slot(:item, title: 'Bar') { 'Dolor Sit' }
        end
      end

      let(:options) do
        { flush: true }
      end

      it { is_expected.to have_selector('.accordion.accordion-flush') }
      it { is_expected.to have_selector('.accordion .accordion-item', count: 2) }
    end
  end
end
