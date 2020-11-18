# frozen_string_literal: true

class StyleValidator < ActiveModel::EachValidator
  STYLES = %i[primary secondary success danger warning info light dark].freeze

  def validate_each(record, attribute, value)
    return if value.in?(STYLES)

    record.errors.add(attribute, :inclusion, valid_styles: STYLES.to_sentence)
  end
end
