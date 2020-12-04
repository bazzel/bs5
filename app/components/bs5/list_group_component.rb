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
      def initialize(options={})
        @options = options.symbolize_keys

        @active = @options.delete(:active) || false
        @disabled = @options.delete(:disabled) || false
        @style = @options.delete(:style)

        set_classnames
      end

      def active?
        !!@active
      end

      def disabled?
        !!@disabled
      end

      def actionable?
        !!actionable_element
      end

      def item_class
        class_names = ['list-group-item']
        class_names << 'active' if active?
        class_names << 'disabled' if disabled?
        class_names << contextual_class if style?
        class_names#.join(' ')
      end

      def item_attributes
        if active?
          @options[:aria] ||= {}
          @options[:aria][:current] = true
        end

        if disabled?
          @options[:aria] ||= {}
          @options[:aria][:disabled] = true
        end

        @options
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
        class_names = (actionable_element[:class] || '').split
        class_names << %w[list-group-item]

        if actionable_element.name.in?(%w[a button])
          class_names << 'list-group-item-action'
        end

        class_names << contextual_class if style?

        if active?
          class_names << 'active'
          actionable_element['aria-current'] = true
        end

        if disabled?
          case actionable_element.name
          when 'a'
            class_names << 'disabled'
            actionable_element['aria-disabled'] = true
            actionable_element['tabindex'] = -1
          when 'button'
            actionable_element['disabled'] = ''
          end
        end

        actionable_element[:class] = class_names.join(' ')

        actionable_element.to_html.html_safe
      end

      def contextual_class
        "list-group-item-#{@style}"
      end

      def style?
        !!@style
      end

      def set_classnames
        classnames = String(@options[:class]).split
        classnames += item_class

        @options[:class] = classnames.join(' ')
      end
    end
  end
end
