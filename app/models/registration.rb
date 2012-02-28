class Registration < ActiveRecord::Base
  validates :email, :email_format => true, :uniqueness => true
  
  scope :recent, lambda {|n = nil| n.nil? ? order("created_at DESC").limit(10) : order("created_at DESC").limit(n)}
  
  def locale
    result = []
    result << language_code.downcase if language_code
    result << country_code.upcase if country_code
    result.reject!(&:blank?)
    result.join("-").to_sym unless result.empty?
  end
  
  def name
    result = []
    result << self.first_name
    result << self.last_name
    result.compact.map(&:strip).reject(&:blank?).join(' ')
  end
  
end
