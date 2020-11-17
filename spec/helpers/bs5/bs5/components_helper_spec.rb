# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe 'Alert' do
      subject { helper.bs5_alert(options) { 'Hello world!' } }
      let(:options) do
        { type: 'secondary',
          is_dismissable: true }
      end

      it {
        p subject
        is_expected.to have_selector('.alert.alert-secondary[role="alert"]', text: 'Hello world!')
        is_expected.to have_selector('.alert.alert-dismissible.fade.show[role="alert"] button.btn-close[type="button"][data-dismiss="alert"][aria-label="Close"]')
      }
    end
  end
end
