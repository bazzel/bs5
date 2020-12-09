# frozen_string_literal: true

module HashRefinement
  refine Hash do
    def prefix_keys_with_bs
      transform_keys! { |k| "bs_#{k}".to_sym }
    end
  end
end
