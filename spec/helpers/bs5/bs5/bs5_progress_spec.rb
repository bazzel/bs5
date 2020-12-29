# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_progress' do
      subject { helper.bs5_progress(value) }

      let(:value) { 25 }
      let(:options) { {} }

      describe 'markup' do
        it {
          is_expected.to have_selector('.progress .progress-bar[role="progressbar"][style="width: 25%"][aria-valuenow="25"][aria-valuemin="0"][aria-valuemax="100"]')
        }
      end
    end
  end
end
