# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_toast_container' do
      subject do
        helper.bs5_toast_container(options) { text }
      end

      let(:options) { {} }
      let(:text) { 'Lorem Ipsum' }

      it { is_expected.to have_selector('.toast-container', text: text) }

      describe 'with extra classes' do
        let(:options) { { class: 'lorem' } }

        it { is_expected.to have_selector('.toast-container.lorem', text: text) }
      end
    end
  end
end
