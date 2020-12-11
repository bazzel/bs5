# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_breadcrumb' do
      subject do
        helper.bs5_breadcrumb do |b|
          b.item { '<a href="#">Home</a>' }
          b.item { 'Library' }
        end
      end

      describe 'markup' do
        it { is_expected.to have_selector('nav[aria-label="breadcrumb"] ol.breadcrumb li.breadcrumb-item', count: 2) }

        describe 'items' do
          it { is_expected.to have_selector('li.breadcrumb-item:not(.active)', text: 'Home') }
          it { is_expected.to have_selector('li.breadcrumb-item.active[aria-current="page"]', text: 'Library') }
        end
      end
    end
  end
end
