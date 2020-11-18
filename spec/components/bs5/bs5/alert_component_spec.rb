# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bs5::AlertComponent, type: :component do
  subject { Capybara.string html }
  let(:html) { render_inline(described_class.new) { 'Hello world!' } }

  describe 'markup' do
    it {
      is_expected.to have_selector('.alert.alert-primary[role="alert"]',
                                   text: 'Hello world!')
    }
  end

  describe 'with `style` specified' do
    let(:html) do
      render_inline(described_class
        .new(options)) { 'Hello world!' }
    end
    let(:options) do
      { style: style }
    end

    describe 'with a valid style' do
      let(:style) { 'primary' }

      it {
        is_expected.to have_selector('.alert.alert-primary[role="alert"]')
      }
    end

    describe 'with an invalid style' do
      let(:style) { 'lorem' }

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

  describe 'without block' do
    subject { Capybara.string html }
    let(:html) { render_inline(described_class.new) }

    it { expect(subject.text).to be_empty }
  end
end
