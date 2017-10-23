actions :bind

attribute :certificate_hash, :kind_of => String
attribute :port, :kind_of => Integer
attribute :ip_address, :kind_of => String, :default => '0.0.0.0'
attribute :app_guid, :kind_of => String, :default => '00000000-0000-0000-0000-000000000000'

def initialize(*args)
  super
  @action = :bind
end
