# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_nav' do
      subject do
        helper.bs5_nav(options) do |lg|
          lg.item(active: true) { tag.a('Lorem', href: '#') }
          lg.item { tag.a('Ipsum', href: '#') }
          lg.item(disabled: true) { tag.a('Dolor', href: '#') }
        end
      end

      let(:options) { {} }

      describe 'markup' do
        it { is_expected.to have_selector('nav.nav a.nav-link', count: 3) }

        describe 'items' do
          describe 'with `active`' do
            it { is_expected.to have_selector('nav.nav a.nav-link.active[aria-current="page"]', text: 'Lorem') }
          end

          describe 'with `disabled`' do
            it { is_expected.to have_selector('nav.nav a.nav-link.disabled[tabindex="-1"][aria-disabled="true"]', text: 'Dolor') }
          end
        end
      end
    end
  end
end
