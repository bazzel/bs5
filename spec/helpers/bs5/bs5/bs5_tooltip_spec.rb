# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_tooltip' do
      subject { helper.bs5_tooltip(title, options) }
      let(:title) { 'my tooltip' }
      let(:options) { {} }

      it { is_expected.to eql({ title: title, data: { bs_toggle: :tooltip } }) }

      describe 'placement' do
        let(:options) { { placement: placement } }
        let(:placement) { :bottom }

        it { is_expected.to eql({ title: title, data: { bs_toggle: :tooltip, bs_placement: :bottom } }) }
      end
    end
  end
end
