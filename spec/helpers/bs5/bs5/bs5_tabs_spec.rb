# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_tabs' do
      subject do
        helper.bs5_tabs(options) do |lg|
          lg.item('Lorem', active: true) { 'Lorem Ipsum' }
          lg.item('Ipsum') { 'Dolor sit' }
        end
      end

      let(:options) { {} }

      describe 'markup' do
        describe 'tabs' do
          it {
            is_expected.to have_selector('nav div.nav.nav-tabs[role="tablist"] a.nav-link[data-bs-toggle="tab"]',
                                         count: 2)
          }

          it {
            is_expected.to have_selector(
              'a.nav-link[id^="nav-"][data-bs-toggle="tab"][href^="#nav-"][role="tab"][aria-controls^="nav-"][aria-selected="false"]', text: 'Ipsum'
            )
          }

          describe 'with `active`' do
            it {
              is_expected.to have_selector(
                'a.nav-link.active[id^="nav-"][data-bs-toggle="tab"][href^="#nav-"][role="tab"][aria-controls^="nav-"][aria-selected="true"]', text: 'Lorem'
              )
            }
          end

          describe 'as pills' do
            let(:options) { { style: :pills } }

            it {
              is_expected.to have_selector('nav div.nav.nav-pills[role="tablist"] a.nav-link[data-bs-toggle="pill"]',
                                           count: 2)
            }
          end
        end

        describe 'panes' do
          it { is_expected.to have_selector('.tab-content .tab-pane', count: 2) }

          it {
            is_expected.to have_selector(
              '.tab-pane.fade[id^="nav-"][role="tabpanel"][aria-labelledby^="nav-"]', text: 'Dolor sit'
            )
          }

          describe 'with `active`' do
            it {
              is_expected.to have_selector(
                '.tab-pane.fade.show.active[id^="nav-"][role="tabpanel"][aria-labelledby^="nav-"]', text: 'Lorem Ipsum'
              )
            }
          end
        end
      end
    end
  end
end
