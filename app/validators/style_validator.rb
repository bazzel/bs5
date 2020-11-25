# frozen_string_literal: true

class StyleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.in?(valid_styles = record.class::STYLES)

    record.errors.add(attribute, :inclusion, valid_styles: valid_styles.to_sentence)
  end
end
