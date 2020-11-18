# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bs5::CloseButtonComponent, type: :component do
  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new) }

  describe 'markup' do
    let(:options) { nil }
    it {
      is_expected.to have_selector('button.btn-close[type="button"][aria-label="Close"]')
    }
  end

  describe 'with options' do
    let(:html) { render_inline(described_class.new(options)) }

    describe 'with `disabled`' do
      let(:options) do
        { disabled: true }
      end

      it {
        is_expected.to have_selector('button.btn-close[disabled]')
      }
    end

    describe 'with `white`' do
      let(:options) do
        { white: true }
      end

      it {
        is_expected.to have_selector('button.btn-close.btn-close-white')
      }
    end

    describe 'without data' do
      let(:options) do
        { data: {
          controller: 'hello',
          action: 'click->hello#greet'
        } }
      end

      it {
        is_expected.to have_selector('button.btn-close[data-controller="hello"][data-action="click->hello#greet"]')
      }
    end
  end
end
