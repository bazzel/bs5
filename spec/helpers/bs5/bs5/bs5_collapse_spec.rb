# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_collapse' do
      subject { helper.bs5_collapse(options) }
      let(:options) { { controls: 'collapseExample'} }

      it { is_expected.to eql({ data: { toggle: :collapse }, aria: { expanded: false, controls: 'collapseExample' }}) }

      describe 'collapsed' do
        let(:options) { { expanded: true, controls: 'collapseExample'} }

        it { is_expected.to eql({ data: { toggle: :collapse }, aria: { expanded: true, controls: 'collapseExample' }}) }
      end

      describe 'target' do
        let(:options) { { target: '#collapseExample' } }

        it { is_expected.to eql({ data: { toggle: :collapse, target: '#collapseExample' }, aria: { expanded: false, controls: 'collapseExample' }}) }
      end

      describe 'aria-controls' do
        describe 'without target or controls' do
          let(:options) { {} }

          it {
            expect do
              subject
            end.to raise_error(RuntimeError)
          }
        end

        describe 'with controls specified' do
          let(:options) { { target: '.multi-collapse', controls: 'multiCollapseExample1 multiCollapseExample2' } }

          it { is_expected.to eql({ data: { toggle: :collapse, target: '.multi-collapse' }, aria: { expanded: false, controls: 'multiCollapseExample1 multiCollapseExample2' }}) }
        end
      end
    end
  end
end
