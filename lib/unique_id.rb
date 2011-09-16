module UniqueId
  module InstanceMethods
    CODE_LENGTH = 32

    private

    def create_random_uid
      self.uid ||= if RUBY_VERSION > "1.9"
        SecureRandom.uuid
      elsif defined?(UUID) && UUID.respond_to?(:create_random)
        UUID.create_random
      else
        rand(36 ** CODE_LENGTH).to_s(36)
      end
    end
  end

  def self.included(klass)
    klass.send :include, InstanceMethods
    klass.validates :uid, :presence => true, :uniqueness => {:case_sensitive => false}
    klass.before_validation :create_random_uid
  end
end
