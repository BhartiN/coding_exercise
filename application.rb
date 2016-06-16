
def require_all(dir)
	Dir["#{dir}/*.rb"].each {|file| require file }
end

require_all './models'

system = System::Main.new()