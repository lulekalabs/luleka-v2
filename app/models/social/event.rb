module Social
  class Event < ActiveRecord::Base
    self.table_name = "social_events"

    CODES = [
      {name: "liked",               label: "Likes"},
      {name: "permissions_denied",  label: "Permissions Denied"},
      {name: "permissions_dialog",  label: "Permissions Dialogs"},
      {name: "permissions_granted", label: "Permissions Granted"},
      {name: "registration",        label: "Registrations"},
      {name: "unique_email",        label: "Unique Emails"},
      {name: "unliked",             label: "Unlikes"},
      {name: "view_invite_page",    label: "Invite Page Views"},
      {name: "wall_post",           label: "Wall Posts"},
    ]

    belongs_to :code
    validates_presence_of :code_id
    validate :code_id_range

    after_create :add_report

    def self.create_from!(request, options = {})
      code_id = options[:code_id] || Code[options[:event_code] || request.params[:event][:event_code]]

      event                 = Event.new
      event.ip_address      = request.remote_ip
      event.code_id         = code_id
      event.viral           = !! options[:viral]
      event.payload         = request.params[:event][:payload] if request.params[:event]
      event.save!
      return event
    end

    def self.sample
      {
        :code_id    => Code["liked"],
        :ip_address => "192.168.1.51"
      }
    end

    def code_id_range
      errors.add(:code_id, 'is out of range') unless (0...CODES.length).include?(code_id)
    end

    def add_report
      report = Report.find_or_create_by_date_and_viral(created_at.to_date, viral)
      Report.increment_counter CODES[code_id][:name], report.id
      report.save!
    end

    def event_code=(string)
      self.code_id = Code[string]
    end

    def event_code
      code.name
    end

    class Code < ActiveRecord::Base
      self.table_name = "social_event_codes"

      def self.[](name)
        CODES.index {|x| x[:name] == name.to_s || x[:label] == name.to_s}
      end

      def self.create_records!
        CODES.each_with_index do |values, index|
          new do |record|
            record.id    = index
            record.name  = values[:name]
            record.label = values[:label]
          end.save!
        end
      end
    end
  end
end