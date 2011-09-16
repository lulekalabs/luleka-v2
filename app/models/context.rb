class Context < ActiveRecord::Base
  belongs_to :kase
  belongs_to :tier
  belongs_to :topic
end
