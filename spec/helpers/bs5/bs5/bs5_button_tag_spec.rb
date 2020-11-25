# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe 'bs5_button_tag' do
      subject { helper.bs5_button_tag }

      describe 'markup' do
        it {
          is_expected.to have_selector('button.btn.btn-primary[name="button"][type="submit"]', text: 'Button')
        }
      end

      describe 'with options' do
        subject { helper.bs5_button_tag('Reset', options) }
        let(:options) { { type: 'reset', disabled: true } }

        it {
          is_expected.to have_selector('button.btn.btn-primary[name="button"][type="reset"][disabled="disabled"]', text: 'Reset')
        }
      end

      describe 'with `style` specified' do
        subject { helper.bs5_button_tag(options) }
        let(:options) { { style: style } }
        let(:style) { 'link' }

        it {
          is_expected.to have_selector('button.btn.btn-link[name="button"][type="submit"]', text: 'Button')
        }

        describe 'with an invalid type' do
          let(:style) { 'lorem' }

          it {
            expect do
              subject
            end.to raise_error(RuntimeError)
          }
        end

        describe 'with options' do
          subject { helper.bs5_button_tag('Reset', options) }
          let(:options) { { style: 'success', type: 'reset', disabled: true } }

          it {
            is_expected.to have_selector('button.btn.btn-success[name="button"][type="reset"][disabled="disabled"]', text: 'Reset')
          }
        end
      end
    end
  end
end
