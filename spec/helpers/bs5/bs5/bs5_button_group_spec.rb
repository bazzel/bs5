# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_button_group' do
      subject { helper.bs5_button_group(options) { 'Hello world!' } }

      let(:options) { {} }

      describe 'markup' do
        it {
          is_expected.to have_selector('.btn-group[role="group"]', text: 'Hello world!')
        }
      end

      describe 'with options' do
        let(:options) { { class: 'lorem', aria: { label: 'my label' } } }

        it {
          is_expected.to have_selector('.btn-group.lorem[role="group"][aria-label="my label"]', text: 'Hello world!')
        }
      end

      describe 'with `size`' do
        describe 'large' do
          let(:options) { { size: :large } }

          it {
            is_expected.to have_selector('.btn-group.btn-group-lg[role="group"]', text: 'Hello world!')
          }
        end

        describe 'small' do
          let(:options) { { size: :small } }

          it {
            is_expected.to have_selector('.btn-group.btn-group-sm[role="group"]', text: 'Hello world!')
          }
        end

        describe 'as string' do
          let(:options) { { size: 'large' } }

          it {
            is_expected.to have_selector('.btn-group.btn-group-lg[role="group"]', text: 'Hello world!')
          }
        end
      end

      describe 'with `vertical`' do
        let(:options) { { vertical: true } }

        it {
          is_expected.to have_selector('.btn-group-vertical[role="group"]', text: 'Hello world!')
        }
      end

      describe 'without block' do
        subject { helper.bs5_button_group }

        it { expect(subject).to be_empty }
      end
    end
  end
end
