# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_alert' do
      subject { helper.bs5_alert(options) { 'Hello world!' } }

      let(:options) { {} }

      describe 'markup' do
        it {
          is_expected.to have_selector('.alert.alert-primary[role="alert"]', text: 'Hello world!')
        }
      end

      describe 'with `style` specified' do
        let(:options) { { style: style } }

        describe 'with a valid style' do
          let(:style) { 'primary' }

          it {
            is_expected.to have_selector('.alert.alert-primary[role="alert"]')
          }
        end

        describe 'with an invalid style' do
          let(:style) { 'lorem' }

          it {
            expect do
              subject
            end.to raise_error(RuntimeError)
          }
        end
      end

      describe 'with `is_dismissable`' do
        let(:options) { { is_dismissable: true } }

        it {
          is_expected.to have_selector('.alert.alert-dismissible.fade.show button.btn-close[type="button"][data-bs-dismiss="alert"][aria-label="Close"]')
        }
      end

      describe 'without block' do
        subject { helper.bs5_alert }

        it { expect(subject).to be_empty }
      end
    end
  end
end
