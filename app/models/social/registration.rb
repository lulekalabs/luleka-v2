module Social
  class Registration < ::Registration
  
    validates :first_name, :presence => true, :length => { :minimum => 2 }
    validates :last_name,  :presence => true, :length => { :minimum => 2 }
    validates :email,      :presence => true, :format => { :with => /\A.+@.+\..+\z/ }

    after_create :create_registration_tracking_event
    after_create :create_unique_email_tracking_event
    before_create :decode_user_data
  
    serialize :user_data
    serialize :fields
  
    # Sample valid attributes usable for tests
    def self.sample
      {
        :first_name => "John",
        :last_name  => "Smith",
        :email      => "johnsmith@example.com",
        :user_data  => "{\"a\":\"b\"}",
        :ip_address => "192.168.1.50"
      }
    end
  
    def create_registration_tracking_event
      Event.create! \
        :ip_address => ip_address,
        :viral      => !! referrer_uid,
        :code_id    => Event::Code["registration"],
        :payload    => id
    end

    def create_unique_email_tracking_event
      count = self.class.where(email: email).count
      return unless count == 1
      Event.create! \
        :ip_address => ip_address,
        :viral      => !! referrer_uid,
        :code_id    => Event::Code["unique_email"],
        :payload    => email
    end

    def decode_user_data
      self.user_data = ActiveSupport::JSON.decode(self.user_data) if self.user_data
      self.uid = self.user_data.try :[], 'id'
    end
  
  end
end