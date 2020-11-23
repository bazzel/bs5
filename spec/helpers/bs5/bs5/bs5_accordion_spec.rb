# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_accordion' do
      subject do
        helper.bs5_accordion(options) do |accordion|
          accordion.slot(:item, title: 'Foo', collapsed: false) { 'Lorem Ipsum' }
          accordion.slot(:item, title: 'Bar') { 'Dolor Sit' }
        end
      end

      let(:options) { {} }

      it { is_expected.to have_selector('.accordion[id^="accordion-"]') }
      it { is_expected.to have_selector('.accordion .accordion-item', count: 2) }

      describe 'item' do
        describe 'header' do
          it { is_expected.to have_selector('.accordion .accordion-item .accordion-header[id^="header-"]') }
          it { is_expected.to have_selector('.accordion .accordion-item .accordion-header button.accordion-button:not(.collapsed)[type="button"][data-toggle="collapse"][data-target^="#collapse-"][aria-expanded="true"][aria-controls^="collapse-"]', text: 'Foo') }
          it { is_expected.to have_selector('.accordion .accordion-item .accordion-header button.accordion-button.collapsed[type="button"][data-toggle="collapse"][data-target^="#collapse-"][aria-expanded="true"][aria-controls^="collapse-"]', text: 'Bar') }
        end

        describe 'body' do
          it { is_expected.to have_selector('.accordion .accordion-item .accordion-collapse.collapse.show[id^="collapse-"][aria-labelledby^="header-"][data-parent^="#accordion-"] .accordion-body', text: 'Lorem Ipsum') }
          it { is_expected.to have_selector('.accordion .accordion-item .accordion-collapse.collapse:not(.show)[id^="collapse-"][aria-labelledby^="header-"][data-parent^="#accordion-"] .accordion-body', text: 'Dolor Sit') }
        end
      end

      describe 'with `flush`' do
        let(:options) { { flush: true } }

        it { is_expected.to have_selector('.accordion.accordion-flush') }
        it { is_expected.to have_selector('.accordion .accordion-item', count: 2) }
      end
    end
  end
end
