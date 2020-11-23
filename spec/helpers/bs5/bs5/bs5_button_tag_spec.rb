# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe 'bs5_button_tag' do
      subject { helper.bs5_button_tag }

      describe 'markup' do
        it {
          is_expected.to have_selector('button.btn.btn-primary[name="button"][type="submit"]', text: 'Button')
        }
      end

      describe 'with options' do
        subject { helper.bs5_button_tag('Reset', options) }
        let(:options) { { type: 'reset', disabled: true } }

        it {
          is_expected.to have_selector('button.btn.btn-primary[name="button"][type="reset"][disabled="disabled"]', text: 'Reset')
        }
      end
    end
  end
end
