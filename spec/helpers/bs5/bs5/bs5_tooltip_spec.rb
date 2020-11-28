# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_tooltip' do
      subject { helper.bs5_tooltip(title, options) }
      let(:title) { 'my tooltip' }
      let(:options) { {} }

      it { is_expected.to eql({ title: title, data: { toggle: :tooltip } }) }

      describe 'placement' do
        let(:options) { { placement: placement } }
        let(:placement) { :bottom }

        it { is_expected.to eql({ title: title, data: { toggle: :tooltip, placement: :bottom } }) }
      end
    end
  end
end
