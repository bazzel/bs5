# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_modal' do
      subject do
        helper.bs5_modal(options) do |m|
          m.controller { bs5_button_tag('Open modal', type: 'button') }
          m.header { 'Title' }
          m.body { 'Body' }
          m.footer { bs5_button_tag('Save', type: 'button') }
        end
      end

      let(:options) { {} }

      it { is_expected.to have_selector('button[type="button"][data-bs-toggle="modal"][data-bs-target]', text: 'Open modal') }
      it { is_expected.to have_selector('div.modal.fade[id][tabindex="-1"][aria-labelledby][aria-hidden="true"] .modal-dialog .modal-content') }

      describe 'header' do
        it { is_expected.to have_selector('.modal.fade .modal-header h5.modal-title[id]', text: 'Title') }
        it { is_expected.to have_selector('.modal.fade .modal-header button.btn-close[data-bs-dismiss="modal"][aria-label="Close"]') }
      end

      describe 'body' do
        it { is_expected.to have_selector('.modal.fade .modal-body', text: 'Body') }
      end

      describe 'footer' do
        it { is_expected.to have_selector('.modal.fade .modal-footer button.btn.btn-secondary[type="button"][data-bs-dismiss="modal"]', text: 'Close') }
        it { is_expected.to have_selector('.modal.fade .modal-footer button.btn.btn-primary[type="button"]', text: 'Save') }
        it { is_expected.to have_selector('.modal.fade .modal-footer .btn-secondary + .btn-primary') }

        describe 'without close button'
      end

      describe 'with JS options' do
        let(:options) do
          {
            backdrop: 'static',
            keyboard: false,
            focus: false
          }
        end

        it { is_expected.to have_selector('.modal.fade[data-bs-backdrop="static"]') }
        it { is_expected.to have_selector('.modal.fade[data-bs-keyboard="false"]') }
        it { is_expected.to have_selector('.modal.fade[data-bs-focus="false"]') }
      end

      describe 'without footer?'
      describe 'without header?'
      describe 'with custom close text'
    end
  end
end
