# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_popover' do
      subject { helper.bs5_popover(options) }
      let(:title) { 'my tooltip' }
      let(:content) { 'my content' }
      let(:options) { { title: title, content: content } }

      it { is_expected.to eql({ title: title, data: { bs_toggle: :popover, bs_content: content } }) }

      describe 'without title' do
        let(:options) { { content: content } }

        it { is_expected.to eql({ data: { bs_toggle: :popover, bs_content: content } }) }
      end

      describe 'placement' do
        let(:options) { { content: content, placement: placement } }
        let(:placement) { :bottom }

        it { is_expected.to eql({ data: { bs_toggle: :popover, bs_content: content, bs_placement: placement } }) }
      end
    end
  end
end
