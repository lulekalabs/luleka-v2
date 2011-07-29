# A Kase instance is a concern or case as in a law case. 
# A Kase is either a question, problem, idea.
class Kase < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :history
  
  #--- attributes
  attr_protected :status, :price
  
end
