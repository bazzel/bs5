# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bs5::AccordionComponent, type: :component do
  subject { Capybara.string html }

  describe 'markup' do
    let(:html) do
      render_inline(described_class.new) do |accordion|
        accordion.slot(:item, title: 'Foo', collapsed: false) { 'Lorem Ipsum' }
        accordion.slot(:item, title: 'Bar') { 'Dolor Sit' }
      end
    end

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
  end

  describe 'with `flush`' do
    let(:html) do
      render_inline(described_class.new(options)) do |accordion|
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
