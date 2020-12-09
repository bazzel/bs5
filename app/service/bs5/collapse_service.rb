# frozen_string_literal: true

module Bs5
  class CollapseService
    using HashRefinement

    CONTROLS_ERR_MSG = 'Please provide either a `controls` option' \
                       ' containing the id of the collapsible element' \
                       ' or an ID selector as `target` options.'

    attr_reader :expanded, :target, :controls

    def initialize(expanded: false, target: nil, controls: nil)
      @expanded = expanded
      @target = target
      @controls = controls
    end

    def to_hash
      {
        data: data_options,
        aria: aria_options
      }
    end

    private

    def data_options
      options = { toggle: :collapse }
      options[:target] = target if target

      options.prefix_keys_with_bs
    end

    def aria_options
      options = { expanded: expanded }

      if controls
        options[:controls] = controls
      elsif target&.start_with?('#')
        options[:controls] = target.delete_prefix('#')
      else
        raise CONTROLS_ERR_MSG
      end

      options
    end
  end
end
