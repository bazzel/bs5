# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_progress' do
      subject { helper.bs5_progress(value, options) }

      let(:value) { 25 }
      let(:options) { {} }

      describe 'markup' do
        it { is_expected.to have_selector('.progress .progress-bar[role="progressbar"][style="width: 25%"][aria-valuenow="25"][aria-valuemin="0"][aria-valuemax="100"]') }
      end

      describe 'with `label`' do
        describe 'with boolean' do
          let(:options) { { label: true } }

          it { is_expected.to have_selector('.progress .progress-bar', text: '25%') }
        end

        describe 'with string'
        let(:options) { { label: 'Lorem Ipsum' } }

        it { is_expected.to have_selector('.progress .progress-bar', text: 'Lorem Ipsum') }
      end

      describe 'with `color`' do
        let(:options) { { color: :secondary } }

        it { is_expected.to have_selector('.progress .progress-bar.bg-secondary') }
      end
    end
  end
end
