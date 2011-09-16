# A Kase instance is a concern or case as in a law case. 
# A Kase is either a question, problem, idea.
class Kase < ActiveRecord::Base
  include UniqueId
  extend FriendlyId
  friendly_id :title, :use => :history
  
  #--- attributes
  attr_protected :status, :price
  
  #--- associations
  has_many :contexts
  has_many :tiers,
    :through => :contexts,
    :source => :tier
  has_many :topics,
    :through => :contexts,
    :source => :topic
end
