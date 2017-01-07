class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    URI.parse(value)
  rescue
    record.errors.add attribute, :invalid
  end
end
