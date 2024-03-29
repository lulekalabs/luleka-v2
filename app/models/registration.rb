class Registration < ActiveRecord::Base
  attr_accessible :email, :time_zone

  acts_as_gmappable :lat => "lat", :lng => "lng", :process_geocoding => false
  
  validates :email, :email_format => true, :uniqueness => true
  
  scope :organic, where("registrations.type IS NULL")
  scope :recent, lambda {|n = nil| n.nil? ? order("created_at DESC") : order("created_at DESC").limit(n)}
  
  class << self
    def instance_for(*attrs, &block)
      secure_options, custom_options = {}, {}
      attrs.each_with_index do |attr, index|
        index == 0 ? secure_options.merge!(normalize_params(attr)) : custom_options.merge!(normalize_params(attr))
      end
      record = new
      custom_options.each {|k, v| record.send("#{k}=", v)}
      record.attributes = secure_options
      yield record if block_given?
      record
    end

    def total_on(date)
      where('date(created_at) = ?', date).count
    end
    
    private
    
    def normalize_params(attributes = {})
      attributes, result = (attributes || {}).symbolize_keys, {}
      if attributes[:ip]
        result[:ip_address]   = attributes[:ip]
        result[:lat]          = attributes[:latitude]
        result[:lng]          = attributes[:longitude]
        result[:city]         = attributes[:city]
        result[:postal_code]  = attributes[:zipcode]
        result[:region_code]  = attributes[:region_code]
        result[:region_name]  = attributes[:region_name]
        result[:country_code] = attributes[:country_code]
      else
        result = attributes
      end
      result.reject {|k,v| v.blank?}
    end
  end
  
  def name
    result = []
    result << self.first_name
    result << self.last_name
    result.compact.map(&:strip).reject(&:blank?).join(' ')
  end

  # Convert from "America/Argentina/Buenos_Aires" to "Buenos Aires"
  def time_zone=(value)
    self[:time_zone] = ActiveSupport::TimeZone::MAPPING.invert[value] ? ActiveSupport::TimeZone::MAPPING.invert[value] : value
  end
  
  def gmaps4rails_address
    result = []
    result << self.city
    result << self.region_code
    result << self.region_name
    result << self.country_code
    result.reject(&:blank?).join(", ")
  end
  
end
