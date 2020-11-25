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

      describe 'with `outline` specified' do
        subject { helper.bs5_button_tag(options) }
        let(:options) { { outline: true } }

        it {
          is_expected.to have_selector('button.btn.btn-outline-primary[name="button"][type="submit"]', text: 'Button')
        }

        describe 'with `style` specified' do
          let(:options) { { outline: true, style: 'warning' } }

          it {
            is_expected.to have_selector('button.btn.btn-outline-warning[name="button"][type="submit"]', text: 'Button')
          }
        end
      end

      describe 'with `size` specified' do
        describe 'large' do
          subject { helper.bs5_button_tag(options) }
          let(:options) { { size: :large } }

          it {
            is_expected.to have_selector('button.btn.btn-primary.btn-lg[name="button"][type="submit"]', text: 'Button')
          }
        end

        describe 'small' do
          subject { helper.bs5_button_tag(options) }
          let(:options) { { size: :small } }

          it {
            is_expected.to have_selector('button.btn.btn-primary.btn-sm[name="button"][type="submit"]', text: 'Button')
          }
        end

        describe 'invalid' do
          subject { helper.bs5_button_tag(options) }
          let(:options) { { size: :invalid } }

          it {
            expect do
              subject
            end.to raise_error(RuntimeError)
          }
        end
      end

      describe 'with extra options' do
        subject { helper.bs5_button_tag('Button', options) }
        let(:options) { { class: 'lorem', data: { toggle: 'button' } } }

        it {
          is_expected.to have_selector('button.btn.btn-primary.lorem[name="button"][data-toggle="button"]', text: 'Button')
        }
      end
    end
  end
end
