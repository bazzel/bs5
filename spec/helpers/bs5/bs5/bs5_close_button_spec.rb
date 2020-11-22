# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe 'bs5_accordion' do
      subject { helper.bs5_close_button(options) }

      describe 'markup' do
        let(:options) { {} }
        it {
          is_expected.to have_selector('button.btn-close[type="button"][aria-label="Close"]')
        }
      end

      describe 'with options' do
        describe 'with `disabled`' do
          let(:options) { { disabled: true } }

          it {
            is_expected.to have_selector('button.btn-close[disabled]')
          }
        end

        describe 'with `white`' do
          let(:options) { { white: true } }

          it {
            is_expected.to have_selector('button.btn-close.btn-close-white')
          }
        end

        describe 'with data' do
          let(:options) do
            { data: {
              controller: 'hello',
              action: 'click->hello#greet'
            } }
          end

          it {
            is_expected.to have_selector('button.btn-close[data-controller="hello"][data-action="click->hello#greet"]')
          }
        end
      end
    end
  end
end
