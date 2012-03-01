module Social
  class Report < ActiveRecord::Base
    self.table_name = "social_reports"

    default_scope :order => "date DESC"

    def self.viral
      where(:viral => true)
    end

    def self.non_viral
      where(:viral => false)
    end

    def self.summary
      sql = %Q{
        SELECT
          viral,
          #{Event::CODES.map {|x| "SUM(#{x[:name]}) AS #{x[:name]}"}.join(", ")}
        FROM reports
        GROUP BY viral
      }
      connection.select_all sql
    end
  end
end