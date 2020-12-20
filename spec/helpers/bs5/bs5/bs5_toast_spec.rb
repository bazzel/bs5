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
        it { is_expected.to have_selector('.toast .toast-header button.btn-close[data-bs-dismiss="toast"][aria-label="Close"]') }
      end

      describe 'body' do
        it { is_expected.to have_selector('.toast .toast-body', text: 'Dolor Sit') }
      end

      describe 'without header' do
        subject do
          helper.bs5_toast(options) do |t|
            t.body { 'Dolor Sit' }
          end
        end

        it { is_expected.to have_selector('.toast[role="alert"][aria-live="assertive"][aria-atomic="true"]') }

        describe 'header' do
          it { is_expected.not_to have_selector('.toast .toast-header') }
        end

        describe 'body' do
          it { is_expected.to have_selector('.toast .toast-body', text: 'Dolor Sit') }
          it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2[data-bs-dismiss="toast"][aria-label="Close"]') }
        end

        describe 'with `color`' do
          describe 'white text' do
            describe 'primary' do
              let(:options) { { color: :primary } }

              it { is_expected.to have_selector('.toast.text-white.bg-primary.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2.btn-close-white') }
            end

            describe 'secondary' do
              let(:options) { { color: :secondary } }

              it { is_expected.to have_selector('.toast.text-white.bg-secondary.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2.btn-close-white') }
            end

            describe 'success' do
              let(:options) { { color: :success } }

              it { is_expected.to have_selector('.toast.text-white.bg-success.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2.btn-close-white') }
            end

            describe 'danger' do
              let(:options) { { color: :danger } }

              it { is_expected.to have_selector('.toast.text-white.bg-danger.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2.btn-close-white') }
            end

            describe 'dark' do
              let(:options) { { color: :dark } }

              it { is_expected.to have_selector('.toast.text-white.bg-dark.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2.btn-close-white') }
            end
          end

          describe 'black text' do
            describe 'warning' do
              let(:options) { { color: :warning } }

              it { is_expected.to have_selector('.toast:not(.text-white).bg-warning.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2:not(.btn-close-white)') }
            end

            describe 'info' do
              let(:options) { { color: :info } }

              it { is_expected.to have_selector('.toast:not(.text-white).bg-info.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2:not(.btn-close-white)') }
            end

            describe 'light' do
              let(:options) { { color: :light } }

              it { is_expected.to have_selector('.toast:not(.text-white).bg-light.border-0') }
              it { is_expected.to have_selector('.toast .toast-body + button.btn-close.ms-auto.me-2:not(.btn-close-white)') }
            end
          end
        end

        describe 'without close button' do
          let(:options) { { close_button: false } }

          it { is_expected.to have_selector('.toast .toast-body', text: 'Dolor Sit') }
          it { is_expected.not_to have_selector('.toast .toast-body + button.btn-close') }
        end
      end

      describe 'with extra classes' do
        let(:options) { { class: 'lorem' } }

        it { is_expected.to have_selector('.toast.lorem[role="alert"][aria-live="assertive"][aria-atomic="true"]') }
      end

      describe 'with JS options' do
        let(:options) { { animation: true, autohide: true, delay: 10_000 } }

        it { is_expected.to have_selector('.toast[data-bs-animation="true"][data-bs-autohide="true"][data-bs-delay="10000"]') }

        describe 'set to false' do
          let(:options) { { autohide: false } }

          it { is_expected.to have_selector('.toast:not([data-bs-animation][data-bs-delay])[data-bs-autohide="false"]') }
        end
      end
    end
  end
end
