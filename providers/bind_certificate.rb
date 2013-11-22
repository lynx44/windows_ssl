#netsh http add sslcert ipport=0.0.0.0:443 certhash=baf9926b466e8565217b5e6287c97973dcd54874 appid={ab3c58f7-8316-42e3-bc6e-771d4ce4b201}

include Chef::Mixin::ShellOut

action :bind do
	hash = @new_resource.hash
	ip_address = @new_resource.ip_address
	port = @new_resource.port
	app_guid = @new_resource.app_guid

  #netsh http show sslcert ipport=0.0.0.0:443

  certificateInfo = getCurrentCertificateInfo()
  Chef::Log.debug("Current certificate info: \n" + certificateInfo)
  unbound = isCertificateBound(certificateInfo)

  if(!unbound)
    verifyCertificateIsBindable(certificateInfo)
  end

	execute "install ssl certificate #{hash}" do
		command "netsh http add sslcert ipport=#{ip_address}:#{port} certhash=#{hash} appid={#{app_guid}}"
    only_if { unbound }
		action :run
	end
end

def getCurrentCertificateInfo
  #netsh http show sslcert ipport=0.0.0.0:443
  shell_out("netsh http show sslcert ipport=#{@new_resource.ip_address}:#{@new_resource.port}").stdout
end

def isCertificateBound(certificateInfo)
  certificateInfo.include?('The system cannot find the file specified.')
end

def getCurrentCertificateHash(certificateInfo)
  #Certificate Hash        : 894deba540a14b35017927f08a8b7188c9af6986
  currentHash = /Certificate Hash\s+:\s+(?<currentHash>[\w]{40})/.match(certificateInfo)['currentHash']

  return currentHash
end

def getCurrentApplicationGuid(certificateInfo)
  #Application ID          : {ab3c58f7-8316-42e3-bc6e-771d4ce4b201}
  currentAppId = /Application ID\s+:\s+\{(?<currentAppId>[\w-]+)\}/.match(certificateInfo)['currentAppId']

  return currentAppId
end

def getCurrentIpAddress(certificateInfo)
  #IP:port                 : 0.0.0.0:443
  ipAddress = /IP:port\s+:\s+(?<ipAddress>([\d]{1,3}\.){3}[\d]{1,3})/.match(certificateInfo)['ipAddress']

  return ipAddress
end

def verifyCertificateIsBindable(certificateInfo)
  currentHash = getCurrentCertificateHash(certificateInfo)
  currentAppGuid = getCurrentApplicationGuid(certificateInfo)
  currentIpAddress = getCurrentIpAddress = getCurrentIpAddress(certificateInfo)
  if(currentHash != @new_resource.hash ||
      currentAppGuid != @new_resource.app_guid ||
      currentIpAddress != @new_resource.ip_address)
    raise "There is already a certificate bound to port #{@new_resource.port}. Conflicting certificate info:\n" + certificateInfo
  end
end