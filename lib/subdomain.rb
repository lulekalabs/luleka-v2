class Subdomain
  class Tier
    def self.matches?(request)
      puts request.inspect
      request.subdomain.present? && request.subdomain != 'www'
    end  
  end
  
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end  
end