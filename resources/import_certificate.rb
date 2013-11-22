
actions :import

attribute :path, :kind_of => String
attribute :password, :kind_of => String
attribute :type, :kind_of => Symbol, :default => :pfx, :equal_to => [:pfx]

def initialize(*args)
  super
  @action = :import
end