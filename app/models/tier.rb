class Tier < ActiveRecord::Base

  #--- associations
  has_many :contexts, :dependent => :destroy
  has_many :kases,
    :through => :contexts,
    :source => :kase,
  
end
