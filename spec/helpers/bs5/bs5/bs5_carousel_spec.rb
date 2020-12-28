# frozen_string_literal: true

require 'rails_helper'

module Bs5
  RSpec.describe ComponentsHelper, type: :helper do
    describe '#bs5_carousel' do
      subject do
        helper.bs5_carousel(options) do |c|
          c.item { tag.div('Lorem Ipsum') }
          c.item { tag.div('Dolor Sit') }
        end
      end

      let(:options) { {} }

      it { is_expected.to have_selector('.carousel.slide[id^="carousel-"][data-bs-ride="carousel"]') }
      it { is_expected.to have_selector('.carousel .carousel-inner .carousel-item', count: 2) }

      describe 'items' do
        it { is_expected.to have_selector('.carousel .carousel-inner .carousel-item.active div.d-block.w-100', text: 'Lorem Ipsum') }
        it { is_expected.to have_selector('.carousel .carousel-inner .carousel-item:not(.active) div.d-block.w-100', text: 'Dolor Sit') }
      end

      describe 'with controls' do
        let(:options) { { controls: true } }

        it { is_expected.to have_selector('.carousel.slide a.carousel-control-prev[href^="#carousel-"][role="button"][data-bs-slide="prev"] span.carousel-control-prev-icon[aria-hidden="true"] + span.visually-hidden') }
        it { is_expected.to have_selector('.carousel.slide a.carousel-control-next[href^="#carousel-"][role="button"][data-bs-slide="next"] span.carousel-control-next-icon[aria-hidden="true"] + span.visually-hidden') }
      end

      describe 'with indicators' do
        let(:options) { { indicators: true } }

        it { is_expected.to have_selector('.carousel.slide ol.carousel-indicators') }

        describe 'items' do
          it { is_expected.to have_selector('.carousel .carousel-indicators li[data-bs-target^="#carousel-"]', count: 2) }
          it { is_expected.to have_selector('.carousel .carousel-indicators li.active[data-bs-slide-to="0"]') }
          it { is_expected.to have_selector('.carousel .carousel-indicators li:not(.active)[data-bs-slide-to="1"]') }
        end
      end

      describe 'with caption' do
        subject do
          helper.bs5_carousel(options) do |c|
            c.item do |i|
              capture do
                concat tag.div('Lorem Ipsum')
                concat i.caption { tag.h5('Dolor Sit') }
              end
            end
          end
        end

        describe 'item' do
          it { is_expected.to have_selector('.carousel .carousel-item .d-block.w-100', text: 'Lorem Ipsum') }
          it { is_expected.to have_selector('.carousel .carousel-item .carousel-caption.d-none.d-md-block', text: 'Dolor Sit') }
        end
      end
    end
  end
end
