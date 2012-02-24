class Registration < ActiveRecord::Base
  validates :email, :email_format => true, :uniqueness => true
  
  def locale
    result = []
    result << language_code.downcase if language_code
    result << country_code.upcase if country_code
    result.reject!(&:blank?)
    result.join("-").to_sym unless result.empty?
  end
end
