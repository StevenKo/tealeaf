module VoteableKoSteven
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_methods
    end
  end

  module InstanceMethods
    def total_votes
      self.votes.where(vote: true).size - self.votes.where(vote: false).size
    end
  end

  module ClassMethods
    def my_class_methods
      puts 'class methods'
      has_many :votes, as: :voteable
    end
  end
end