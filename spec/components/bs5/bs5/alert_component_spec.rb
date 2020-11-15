# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bs5::AlertComponent, type: :component do
  subject       { Capybara.string html }
  let(:html)    { render_inline(described_class.new) { 'Hello world!' } }

  describe 'markup' do
    it {
      is_expected.to have_selector('.alert.alert-primary[role="alert"]',
                                   text: 'Hello world!')
    }
  end

  describe 'with `type` specified' do
    let(:html) do
      render_inline(described_class
      .new(options)) { 'Hello world!' }
    end
    let(:options) do
      { type: type }
    end

    describe 'with a valid type' do
      let(:type) { 'primary' }

      it {
        is_expected.to have_selector('.alert.alert-primary[role="alert"]')
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

  describe 'with `is_dismissable`' do
    let(:html) do
      render_inline(described_class
      .new(options)) { 'Hello world!' }
    end
    let(:options) do
      { is_dismissable: true }
    end

    it {
      is_expected.to have_selector('.alert.alert-dismissible.fade.show button.btn-close[type="button"][data-dismiss="alert"][aria-label="Close"]')
    }
  end
end
