# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_toast' do
      subject do
        helper.bs5_toast(options) do |t|
          t.header { 'Lorem Ipsum' }
          t.body { 'Dolor Sit' }
        end
      end

      let(:options) { {} }

      it { is_expected.to have_selector('.toast[role="alert"][aria-live="assertive"][aria-atomic="true"]') }

      describe 'header' do
        it { is_expected.to have_selector('.toast .toast-header', text: 'Lorem Ipsum') }
      end

      describe 'body' do
        it { is_expected.to have_selector('.toast .toast-body', text: 'Dolor Sit') }
      end
    end
  end
end
