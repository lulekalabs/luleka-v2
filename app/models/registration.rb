class Registration < ActiveRecord::Base
  validates :email, :email_format => true, :uniqueness => true
  
  scope :recent, lambda {|n = nil| n.nil? ? order("created_at DESC").limit(10) : order("created_at DESC").limit(n)}
  
  
  class << self
    def instance_for(*attrs)
      options = {}
      (attrs).each do |attr|
        puts normalize_params(attr)
        options.merge! normalize_params(attr)
      end
      new options
    end
    
    private
    
    def normalize_params(attributes = {})
      attributes, result    = (attributes || {}).symbolize_keys, {}
      if attributes[:ip]
        result[:ip_address]   = attributes[:ip]
        result[:lat]          = attributes[:latitude]
        result[:lng]          = attributes[:longitude]
        result[:country_code] = attributes[:country_code]
        result[:postal_code]  = attributes[:zipcode]
        result[:metrocode]    = attributes[:metrocode]
        result[:city]         = attributes[:city]
      else
        result = attributes
      end
      result.reject {|k,v| v.blank? || v.match(/0/)}
    end
  end
  
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
