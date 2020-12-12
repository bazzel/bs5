# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_spinner' do
      subject { helper.bs5_spinner(options) }

      let(:options) { {} }

      describe 'markup' do
        it {
          is_expected.to have_selector('.spinner-border[role="status"]')
        }
      end

      describe 'with `text` specified' do
        let(:options) { { text: text } }
        let(:text) { 'Lorem Ipsum...' }

        it {
          is_expected.to have_selector('.spinner-border[role="status"] span.visually-hidden', text: text)
        }
      end

      describe 'with `color` specified' do
        let(:options) { { color: color } }

        describe 'with a valid color' do
          let(:color) { 'primary' }

          it {
            is_expected.to have_selector('.spinner-border.text-primary[role="status"]')
          }
        end

        describe 'with an invalid color' do
          let(:color) { 'lorem' }

          it {
            expect do
              subject
            end.to raise_error(RuntimeError)
          }
        end
      end

      describe 'with `grow` specified' do
        let(:options) { { grow: true } }

        it {
          is_expected.to have_selector('.spinner-grow[role="status"]')
        }
      end

      describe 'with `size` specified' do
        let(:options) { { size: size } }

        describe 'small' do
          let(:size) { :small }

          it {
            is_expected.to have_selector('.spinner-border.spinner-border-sm[role="status"]')
          }
        end

        describe 'large' do
          let(:size) { :large }

          it {
            is_expected.to have_selector('.spinner-border.spinner-border-lg[role="status"]')
          }
        end

        describe 'with `grow` specified' do
          let(:options) { { grow: true, size: size } }

          describe 'small' do
            let(:size) { :small }

            it {
              is_expected.to have_selector('.spinner-grow.spinner-grow-sm[role="status"]')
            }
          end

          describe 'large' do
            let(:size) { :large }

            it {
              is_expected.to have_selector('.spinner-grow.spinner-grow-lg[role="status"]')
            }
          end
        end
      end

      describe 'with extra classes' do
        let(:options) { { class: 'lorem' } }

        it {
          is_expected.to have_selector('.spinner-border.lorem[role="status"]')
        }
      end

      describe 'with extra options' do
        let(:options) { { aria: { hidden: true } } }

        it {
          is_expected.to have_selector('.spinner-border[role="status"][aria-hidden="true"]')
        }
      end
    end
  end
end
