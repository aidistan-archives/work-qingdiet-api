class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI.parse(value)

    # Option :query, default to :nil
    case @options[:query]
    when true
      raise 'must has a query' unless uri.query
    when false
      raise 'must has no query' if uri.query
    end
  rescue StandardError => e
    record.errors.add attribute, :invalid, message: e.message
  end
end
