# frozen_string_literal: true

module Bs5
  class ListGroupComponent < ViewComponent::Base
    CLASS_NAME_BASE = 'list-group'
    CLASS_NAME_FLUSH = "#{CLASS_NAME_BASE}-flush"
    CLASS_NAME_HORIZONTAL = "#{CLASS_NAME_BASE}-horizontal"

    include ViewComponent::SlotableV2

    renders_many :items, 'Item'

    def initialize(flush: false, horizontal: false)
      @flush = flush
      @horizontal = horizontal
    end

    private

    def flush?
      !!@flush
    end

    def actionables?
      items.any? do |item|
        elements = Nokogiri::HTML::DocumentFragment.parse(item.to_s).elements
        elements.one? && elements.first.name.in?(%w[a button label])
      end
    end

    def horizontal?
      !!@horizontal
    end

    def component_class
      class_names = [CLASS_NAME_BASE]
      class_names << flush_class
      class_names << horizontal_class
      class_names.join(' ')
    end

    def flush_class
      CLASS_NAME_FLUSH if flush?
    end

    def horizontal_class
      return unless horizontal?

      class_names = [CLASS_NAME_HORIZONTAL]
      class_names << @horizontal if @horizontal.in?(%i[sm md lg xl xxl])
      class_names.join('-')
    end

    class Item < ViewComponent::Base
      CLASS_NAME_BASE = 'list-group-item'
      CLASS_NAME_ACTION = "#{CLASS_NAME_BASE}-action"

      attr_reader :options

      def initialize(options = {})
        @options = options.symbolize_keys

        @active = @options.delete(:active) || false
        @disabled = @options.delete(:disabled) || false
        @style = @options.delete(:style)

        set_attributes
      end

      def call
        actionable? ? decorated_content : content
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
        class_names << CLASS_NAME_ACTION if actionable_element.name.in?(%w[a button])
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
        class_names = [CLASS_NAME_BASE]
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
        [CLASS_NAME_BASE, @style].join('-')
      end
    end
  end
end
