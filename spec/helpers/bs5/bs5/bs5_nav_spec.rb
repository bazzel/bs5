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

          describe 'with extra classes' do
            subject do
              helper.bs5_nav(options) do |lg|
                lg.item(active: true, class: 'lorem ipsum') { tag.a('Lorem', href: '#') }
              end
            end

            it { is_expected.to have_selector('nav.nav a.nav-link.active.lorem.ipsum', text: 'Lorem') }
          end
        end
      end

      describe 'with extra classes' do
        let(:options) { { class: 'lorem' } }

        it { is_expected.to have_selector('nav.nav.lorem') }
      end

      describe 'with `style`' do
        describe 'with `tabs' do
          let(:options) { { style: :tabs } }

          it { is_expected.to have_selector('nav.nav.nav-tabs') }
        end

        describe 'with `pills' do
          let(:options) { { style: :pills } }

          it { is_expected.to have_selector('nav.nav.nav-pills') }
        end
      end

      describe 'with `space`' do
        describe 'with `tabs' do
          let(:options) { { space: :fill } }

          it { is_expected.to have_selector('nav.nav.nav-fill') }
        end

        describe 'with `pills' do
          let(:options) { { space: :justified } }

          it { is_expected.to have_selector('nav.nav.nav-justified') }
        end
      end
    end
  end
end
