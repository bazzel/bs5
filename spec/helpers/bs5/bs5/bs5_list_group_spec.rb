# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_list_group' do
      subject do
        helper.bs5_list_group(options) do |lg|
          lg.slot(:item) { 'Lorem' }
          lg.slot(:item) { 'Ipsum' }
        end
      end

      let(:options) { {} }

      describe 'markup' do
        it { is_expected.to have_selector('ul.list-group li.list-group-item', count: 2) }

        describe 'with `flush`' do
          let(:options) { { flush: true } }

          it { is_expected.to have_selector('ul.list-group.list-group-flush li.list-group-item', count: 2) }
        end

        describe 'items' do
          describe 'with `active`' do
            subject do
              helper.bs5_list_group do |lg|
                lg.slot(:item) { 'Lorem' }
                lg.slot(:item, active: true) { 'Ipsum' }
              end
            end

            it { is_expected.to have_selector('ul.list-group li.list-group-item:not(.active)', text: 'Lorem') }
            it { is_expected.to have_selector('ul.list-group li.list-group-item.active[aria-current="true"]', text: 'Ipsum') }
          end

          describe 'with `disabled`' do
            subject do
              helper.bs5_list_group do |lg|
                lg.slot(:item) { 'Lorem' }
                lg.slot(:item, disabled: true) { 'Ipsum' }
              end
            end

            it { is_expected.to have_selector('ul.list-group li.list-group-item:not(.active)', text: 'Lorem') }
            it { is_expected.to have_selector('ul.list-group li.list-group-item.disabled[aria-disabled="true"]', text: 'Ipsum') }
          end

          describe 'actionables' do
            subject do
              helper.bs5_list_group do |lg|
                lg.slot(:item) { tag.a('Lorem', href: '#') }
                lg.slot(:item) { tag.button('Ipsum', type: :button) }
                lg.slot(:item) { label_tag('name', 'Dolor') }
              end
            end

            it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action', text: 'Lorem') }
            it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action', text: 'Ipsum') }
            it { is_expected.to have_selector('div.list-group label.list-group-item:not(.list-group-item-action)[for="name"]', text: 'Dolor') }

            describe 'with `active`' do
              subject do
                helper.bs5_list_group do |lg|
                  lg.slot(:item, active: true) { tag.a('Lorem', href: '#') }
                  lg.slot(:item) { tag.button('Ipsum', type: :button) }
                  lg.slot(:item) { tag.a('Dolor', href: '#', class: 'active') }
                end
              end

              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.active[aria-current="true"]', text: 'Lorem') }
              it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action:not(.active)', text: 'Ipsum') }
              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.active', text: 'Dolor') }
            end

            describe 'with `disabled`' do
              subject do
                helper.bs5_list_group do |lg|
                  lg.slot(:item, disabled: true) { tag.a('Lorem', href: '#') }
                  lg.slot(:item, disabled: true) { tag.button('Ipsum', type: :button) }
                end
              end

              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.disabled[tabindex="-1"][aria-disabled="true"]', text: 'Lorem') }
              it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action[disabled]', text: 'Ipsum') }
            end

            describe 'with `style`' do
              subject do
                helper.bs5_list_group do |lg|
                  lg.slot(:item, style: :primary) { tag.a('Lorem', href: '#') }
                  lg.slot(:item, style: :warning) { tag.button('Ipsum', type: :button) }
                end
              end

              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.list-group-item-primary', text: 'Lorem') }
              it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action.list-group-item-warning', text: 'Ipsum') }
            end
          end

          describe 'with `style`' do
            subject do
              helper.bs5_list_group do |lg|
                lg.slot(:item, style: :primary) { 'Lorem' }
                lg.slot(:item, style: :warning) { 'Ipsum' }
              end

              it { is_expected.to have_selector('ul.list-group li.list-group-item.list-group-item-primary', text: 'Lorem') }
              it { is_expected.to have_selector('ul.list-group li.list-group-item.list-group-item-warning', text: 'Ipsum') }
            end

          end
        end
      end
    end
  end
end
