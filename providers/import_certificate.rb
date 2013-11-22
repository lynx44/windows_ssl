include Windows::Helper

action :import do
  pfxpath = cached_file(@new_resource.path)
	password = @new_resource.password
	windows_batch "import certificate #{pfxpath}" do
		code "certutil -p #{password} -importpfx #{pfxpath}"
		action :run
	end
end