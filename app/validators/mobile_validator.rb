class MobileValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A1[34578][0-9]\d{8}\z/i
      record.errors.add attribute, :invalid
    end
  end
end
