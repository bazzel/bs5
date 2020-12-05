# frozen_string_literal: true

module Bs5
  class ListGroupComponent < ViewComponent::Base
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: 'Item'

    def initialize(flush: false)
      @flush = flush
    end

    def flush?
      !!@flush
    end

    def actionables?
      items.any?(&:actionable?)
    end

    def component_class
      class_names = ['list-group']
      class_names << 'list-group-flush' if flush?
      class_names.join(' ')
    end

    class Item < ViewComponent::Slot
      attr_reader :options

      def initialize(options = {})
        @options = options.symbolize_keys

        @active = @options.delete(:active) || false
        @disabled = @options.delete(:disabled) || false
        @style = @options.delete(:style)

        set_attributes
      end

      def actionable?
        !!actionable_element
      end

      def actionable_element
        @actionable_element ||= begin
          if (elements = Nokogiri::HTML::DocumentFragment.parse(content).elements).one? &&
             (element = elements.first).name.in?(%w[a button label])
            element
          end
        end
      end

      def decorated_content
        set_actionable_element_attributes
        actionable_element.to_html.html_safe # rubocop:disable Rails/OutputSafety
      end

      private

      def set_actionable_element_class_names
        class_names = Array(actionable_element[:class])
        class_names << item_classes
        class_names << 'list-group-item-action' if actionable_element.name.in?(%w[a button])
        actionable_element[:class] = class_names.join(' ')
      end

      def set_actionable_element_attributes
        set_actionable_element_class_names
        actionable_element['aria-current'] = true if active?

        return unless disabled?

        case actionable_element.name
        when 'a'
          actionable_element['aria-disabled'] = true
          actionable_element['tabindex'] = -1
        when 'button'
          actionable_element['disabled'] = ''
        end
      end

      def set_attributes
        @options[:class] = Array(@options[:class])
        @options[:class] << item_classes
        @options[:aria] ||= {}
        @options[:aria][:current] = true if active?
        @options[:aria][:disabled] = true if disabled?
      end

      def item_classes
        class_names = %w[list-group-item]
        class_names << 'active' if active?
        class_names << 'disabled' if disabled?
        class_names << contextual_class if style?

        class_names
      end

      def active?
        !!@active
      end

      def disabled?
        !!@disabled
      end

      def style?
        !!@style
      end

      def contextual_class
        "list-group-item-#{@style}"
      end
    end
  end
end
