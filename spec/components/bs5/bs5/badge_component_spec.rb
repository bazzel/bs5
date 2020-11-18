# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bs5::BadgeComponent, type: :component do
  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new(options)) }
  let(:options) { { text: text } }
  let(:text) { 'Hello world!' }

  describe 'markup' do
    it {
      is_expected.to have_selector('.badge.bg-secondary', text: text)
    }
  end

  describe 'with `type` specified' do
    let(:options) { { text: text, type: type } }

    describe 'that has light text' do
      let(:type) { 'success' }

      it {
        is_expected.to have_selector('.badge.bg-success:not(.text-dark)', text: text)
      }
    end

    describe 'that has dark text' do
      let(:type) { 'warning' }

      it {
        is_expected.to have_selector('.badge.bg-warning.text-dark', text: text)
      }
    end

    describe 'with an invalid type' do
      let(:type) { 'lorem' }

      it {
        expect do
          subject
        end.to raise_error(RuntimeError)
      }
    end
  end

  describe 'with `pill`' do
    let(:options) { { text: text, pill: true } }

    it {
      is_expected.to have_selector('.badge.bg-secondary.rounded-pill', text: text)
    }
  end
end
