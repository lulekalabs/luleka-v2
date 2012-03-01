ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'valid_attributes'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module ActiveSupport
  class TestCase
    include Shoulda::Matchers::ActiveModel
    extend Shoulda::Matchers::ActiveModel

    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly in integration tests
    # -- they do not yet inherit this setting
    fixtures :all

    def assert_error_on(record, *fields)
      record.valid?
      fields.each do |field|
        assert !record.errors[field.to_sym].empty?, "expected errors on #{field}"
      end
    end

    def assert_no_error_on(record, *fields)
      record.valid?
      fields.each do |field|
        assert record.errors[field.to_sym].empty?, "expected no errors on #{field}"
      end
    end

    def set_up_ambry
      Ambry.remove_adapter :cookie
      Ambry::Adapter.new :name => :cookie
    end

    def tear_down_ambry
      Ambry.remove_adapter :cookie
    end

    def transaction
      ActiveRecord::Base.connection.transaction do
        yield
        raise ActiveRecord::Rollback
      end
    end

    def with_report_fixtures(&block)
      transaction do
        5.times.each do |i|
          [Date.today - i].each do |date|
            [true, false].each do |bool|
              report = Social::Report.new date: date, viral: bool
              Social::Event::CODES.each do |code|
                report.send "#{code[:name]}=", rand(5)
              end
              report.save!
            end
          end
        end
        yield
      end
    end

  end
end
