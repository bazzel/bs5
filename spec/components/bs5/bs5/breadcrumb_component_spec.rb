# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bs5::BreadcrumbComponent, type: :component do
  subject { Capybara.string html }

  describe 'markup' do
    let(:html) do
      render_inline(described_class.new) do |breadcrumb|
        breadcrumb.slot(:item) { '<a href="#">Home</a>' }
        breadcrumb.slot(:item) { 'Library' }
      end
    end

    it { is_expected.to have_selector('nav[aria-label="breadcrumb"] ol.breadcrumb li.breadcrumb-item', count: 2) }

    describe 'items' do
      it { is_expected.to have_selector('li.breadcrumb-item:not(.active)', text: 'Home') }
      it { is_expected.to have_selector('li.breadcrumb-item.active[aria-current="page"]', text: 'Library') }
    end
  end
end
