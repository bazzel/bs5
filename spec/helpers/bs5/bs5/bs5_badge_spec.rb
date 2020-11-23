# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_badge' do
      subject { helper.bs5_badge(options) }
      let(:options) { { text: text } }
      let(:text) { 'Hello world!' }

      describe 'markup' do
        it {
          is_expected.to have_selector('.badge.bg-secondary', text: text)
        }
      end

      describe 'with `type` specified' do
        let(:options) { { text: text, style: style } }

        describe 'that has light text' do
          let(:style) { 'success' }

          it {
            is_expected.to have_selector('.badge.bg-success:not(.text-dark)', text: text)
          }
        end

        describe 'that has dark text' do
          let(:style) { 'warning' }

          it {
            is_expected.to have_selector('.badge.bg-warning.text-dark', text: text)
          }
        end

        describe 'with an invalid type' do
          let(:style) { 'lorem' }

          it {
            expect do
              subject
            end.to raise_error(RuntimeError)
          }
        end
      end

      describe 'with `pill`' do
        let(:options) { { text: text, pill: true } }

        it {
          is_expected.to have_selector('.badge.bg-secondary.rounded-pill', text: text)
        }
      end
    end
  end
end
