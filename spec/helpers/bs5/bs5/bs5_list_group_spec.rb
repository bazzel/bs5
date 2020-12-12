# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_list_group' do
      subject do
        helper.bs5_list_group(options) do |lg|
          lg.item { 'Lorem' }
          lg.item { 'Ipsum' }
        end
      end

      let(:options) { {} }

      describe 'markup' do
        it { is_expected.to have_selector('ul.list-group li.list-group-item', count: 2) }

        describe 'with `flush`' do
          let(:options) { { flush: true } }

          it { is_expected.to have_selector('ul.list-group.list-group-flush li.list-group-item', count: 2) }
        end

        describe 'with `horizontal`' do
          describe 'without breakpoint' do
            let(:options) { { horizontal: true } }

            it { is_expected.to have_selector('ul.list-group.list-group-horizontal li.list-group-item', count: 2) }
          end

          describe 'with breakpoint' do
            describe 'sm' do
              let(:options) { { horizontal: :sm } }

              it { is_expected.to have_selector('ul.list-group.list-group-horizontal-sm li.list-group-item', count: 2) }
            end
            describe 'md' do
              let(:options) { { horizontal: :md } }

              it { is_expected.to have_selector('ul.list-group.list-group-horizontal-md li.list-group-item', count: 2) }
            end
            describe 'lg' do
              let(:options) { { horizontal: :lg } }

              it { is_expected.to have_selector('ul.list-group.list-group-horizontal-lg li.list-group-item', count: 2) }
            end
            describe 'xl' do
              let(:options) { { horizontal: :xl } }

              it { is_expected.to have_selector('ul.list-group.list-group-horizontal-xl li.list-group-item', count: 2) }
            end
            describe 'xxl' do
              let(:options) { { horizontal: :xxl } }

              it { is_expected.to have_selector('ul.list-group.list-group-horizontal-xxl li.list-group-item', count: 2) }
            end
          end
        end

        describe 'items' do
          describe 'with `active`' do
            subject do
              helper.bs5_list_group do |lg|
                lg.item { 'Lorem' }
                lg.item(active: true) { 'Ipsum' }
              end
            end

            it { is_expected.to have_selector('ul.list-group li.list-group-item:not(.active)', text: 'Lorem') }
            it { is_expected.to have_selector('ul.list-group li.list-group-item.active[aria-current="true"]', text: 'Ipsum') }
          end

          describe 'with `disabled`' do
            subject do
              helper.bs5_list_group do |lg|
                lg.item { 'Lorem' }
                lg.item(disabled: true) { 'Ipsum' }
              end
            end

            it { is_expected.to have_selector('ul.list-group li.list-group-item:not(.active)', text: 'Lorem') }
            it { is_expected.to have_selector('ul.list-group li.list-group-item.disabled[aria-disabled="true"]', text: 'Ipsum') }
          end

          describe 'actionables' do
            subject do
              helper.bs5_list_group do |lg|
                lg.item { tag.a('Lorem', href: '#') }
                lg.item { tag.button('Ipsum', type: :button) }
                lg.item { label_tag('name', 'Dolor') }
              end
            end

            it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action', text: 'Lorem') }
            it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action', text: 'Ipsum') }
            it { is_expected.to have_selector('div.list-group label.list-group-item:not(.list-group-item-action)[for="name"]', text: 'Dolor') }

            describe 'with `active`' do
              subject do
                helper.bs5_list_group do |lg|
                  lg.item(active: true) { tag.a('Lorem', href: '#') }
                  lg.item { tag.button('Ipsum', type: :button) }
                  lg.item { tag.a('Dolor', href: '#', class: 'active') }
                end
              end

              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.active[aria-current="true"]', text: 'Lorem') }
              it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action:not(.active)', text: 'Ipsum') }
              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.active', text: 'Dolor') }
            end

            describe 'with `disabled`' do
              subject do
                helper.bs5_list_group do |lg|
                  lg.item(disabled: true) { tag.a('Lorem', href: '#') }
                  lg.item(disabled: true) { tag.button('Ipsum', type: :button) }
                end
              end

              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.disabled[tabindex="-1"][aria-disabled="true"]', text: 'Lorem') }
              it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action[disabled]', text: 'Ipsum') }
            end

            describe 'with `style`' do
              subject do
                helper.bs5_list_group do |lg|
                  lg.item(style: :primary) { tag.a('Lorem', href: '#') }
                  lg.item(style: :warning) { tag.button('Ipsum', type: :button) }
                end
              end

              it { is_expected.to have_selector('div.list-group a.list-group-item.list-group-item-action.list-group-item-primary', text: 'Lorem') }
              it { is_expected.to have_selector('div.list-group button.list-group-item.list-group-item-action.list-group-item-warning', text: 'Ipsum') }
            end
          end

          describe 'with `style`' do
            subject do
              helper.bs5_list_group do |lg|
                lg.item(style: :primary) { 'Lorem' }
                lg.item(style: :warning) { 'Ipsum' }
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
