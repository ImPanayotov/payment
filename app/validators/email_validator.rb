class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || value.match(Devise.email_regexp)

    record.errors.add attribute, 'is invalid'
  end
end
