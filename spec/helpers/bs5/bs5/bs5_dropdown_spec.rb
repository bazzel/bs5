# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_dropdown' do
      subject do
        helper.bs5_dropdown('Dropdown button', options) do |d|
          d.item { tag.a('Action', href: '#') }
          d.item { tag.a('Another action', href: '#') }
        end
      end

      let(:options) { {} }

      describe 'markup' do
        it { is_expected.to have_selector('.dropdown button.btn.btn-primary.dropdown-toggle[type="button"][data-bs-toggle="dropdown"][aria-expanded="false"]', text: 'Dropdown button') }

        describe 'items' do
          it { is_expected.to have_selector('.dropdown button + ul.dropdown-menu') }
          it { is_expected.to have_selector('.dropdown ul.dropdown-menu li a.dropdown-item', text: 'Action') }
          it { is_expected.to have_selector('.dropdown ul.dropdown-menu li a.dropdown-item', text: 'Another action') }
        end

        describe 'empty item draws a divider' do
          subject do
            helper.bs5_dropdown(options) do |d|
              d.item { tag.a('Action', href: '#') }
              d.item
              d.item { tag.a('Another action', href: '#') }
            end
          end

          describe 'items' do
            it { is_expected.to have_selector('.dropdown button + ul.dropdown-menu li', count: 3) }
            it { is_expected.to have_selector('.dropdown ul.dropdown-menu li a.dropdown-item', count: 2) }
            it { is_expected.to have_selector('.dropdown ul.dropdown-menu li:nth-child(2) hr.dropdown-divider') }
          end
        end
      end

      describe 'with `color`' do
        let(:options) { { color: :secondary } }

        it { is_expected.to have_selector('.dropdown button.btn.btn-secondary.dropdown-toggle', text: 'Dropdown button') }
      end

      describe 'with `outline`' do
        let(:options) { { outline: true } }

        it { is_expected.to have_selector('.dropdown button.btn.btn-outline-primary.dropdown-toggle', text: 'Dropdown button') }
      end

      describe 'with `size`' do
        let(:options) { { size: :large } }

        it { is_expected.to have_selector('.dropdown button.btn.btn-lg.btn-primary.dropdown-toggle', text: 'Dropdown button') }
      end

      describe 'with `dark`' do
        let(:options) { { dark: true } }

        it { is_expected.to have_selector('.dropdown ul.dropdown-menu.dropdown-menu-dark') }
      end

      describe 'directions' do
        describe 'with `up`' do
          let(:options) { { direction: :up } }

          it { is_expected.to have_selector('.dropdown.dropup') }
        end

        describe 'with `end`' do
          let(:options) { { direction: :end } }

          it { is_expected.to have_selector('.dropdown.dropend') }
        end

        describe 'with `start`' do
          let(:options) { { direction: :start } }

          it { is_expected.to have_selector('.dropdown.dropstart') }
        end
      end

      describe 'with `split`' do
        let(:options) { { split: true } }

        it { is_expected.to have_selector('.btn-group button.btn.btn-primary', text: 'Dropdown button') }
        it { is_expected.to have_selector('.btn-group button.btn.btn-primary.dropdown-toggle.dropdown-toggle-split[type="button"][data-bs-toggle="dropdown"][aria-expanded="false"] span.visually-hidden', text: 'Toggle Dropdown') }

        describe 'items' do
          it { is_expected.to have_selector('.btn-group .dropdown-toggle + ul.dropdown-menu') }
          it { is_expected.to have_selector('.btn-group ul.dropdown-menu li a.dropdown-item', text: 'Action') }
          it { is_expected.to have_selector('.btn-group ul.dropdown-menu li a.dropdown-item', text: 'Another action') }
        end

        describe 'with `color`' do
          let(:options) { { split: true, color: :secondary } }

          it { is_expected.to have_selector('.btn-group button.btn.btn-secondary', text: 'Dropdown button') }
          it { is_expected.to have_selector('.btn-group button.btn.btn-secondary.dropdown-toggle.dropdown-toggle-split[type="button"][data-bs-toggle="dropdown"][aria-expanded="false"] span.visually-hidden', text: 'Toggle Dropdown') }
        end

        describe 'with `outline`' do
          let(:options) { { split: true, outline: true } }

          it { is_expected.to have_selector('.btn-group button.btn.btn-outline-primary', text: 'Dropdown button') }
          it { is_expected.to have_selector('.btn-group button.btn.btn-outline-primary.dropdown-toggle.dropdown-toggle-split[type="button"][data-bs-toggle="dropdown"][aria-expanded="false"] span.visually-hidden', text: 'Toggle Dropdown') }
        end

        describe 'with `size`' do
          let(:options) { { split: true, size: :small } }

          it { is_expected.to have_selector('.btn-group button.btn.btn-sm.btn-primary', text: 'Dropdown button') }
          it { is_expected.to have_selector('.btn-group button.btn.btn-sm.btn-primary.dropdown-toggle.dropdown-toggle-split[type="button"][data-bs-toggle="dropdown"][aria-expanded="false"] span.visually-hidden', text: 'Toggle Dropdown') }
        end

        describe 'with `dark`' do
          let(:options) { { split: true, dark: true } }

          it { is_expected.to have_selector('.btn-group ul.dropdown-menu.dropdown-menu-dark') }
        end

        describe 'directions' do
          describe 'with `up`' do
            let(:options) { { split: true, direction: :up } }

            it { is_expected.to have_selector('.btn-group.dropup button + button.dropdown-toggle.dropdown-toggle-split + ul.dropdown-menu') }
          end

          describe 'with `end`' do
            let(:options) { { split: true, direction: :end } }

            it { is_expected.to have_selector('.btn-group.dropend button + button.dropdown-toggle.dropdown-toggle-split + ul.dropdown-menu') }
          end

          describe 'with `start`' do
            let(:options) { { split: true, direction: :start } }

            it { is_expected.to have_selector('.btn-group .btn-group.dropstart button.dropdown-toggle.dropdown-toggle-split + ul.dropdown-menu') }
            it { is_expected.to have_selector('.btn-group .btn-group.dropstart + button:not(.dropdown-toggle)') }
          end
        end
      end

      describe 'with buttons' do
        subject do
          helper.bs5_dropdown('Dropdown button', options) do |d|
            d.item { button_tag('Action') }
          end
        end

        it { is_expected.to have_selector('.dropdown ul.dropdown-menu li button.dropdown-item', text: 'Action') }
      end

      describe 'with non-actionable tags' do
        subject do
          helper.bs5_dropdown('Dropdown button', options) do |d|
            d.item { tag.span('Action', class: 'my-class') }
          end
        end

        it { is_expected.to have_selector('.dropdown ul.dropdown-menu li span.my-class:not(.dropdown-item)', text: 'Action') }
      end

      describe 'with `align`' do
        describe 'with Symbol specified' do
          let(:options) { { align: :end } }

          it { is_expected.to have_selector('.dropdown button + ul.dropdown-menu.dropdown-menu-end') }
        end

        describe 'with Hash specified' do
          describe 'with `:end`' do
            let(:options) { { align: { end: :lg } } }

            it { is_expected.to have_selector('.dropdown button[data-bs-display="static"] + ul.dropdown-menu.dropdown-menu-lg-end') }
          end

          describe 'with `:start`' do
            let(:options) { { align: { start: :lg } } }

            it { is_expected.to have_selector('.dropdown button[data-bs-display="static"] + ul.dropdown-menu.dropdown-menu-end.dropdown-menu-lg-start') }
          end
        end
      end
    end
  end
end
