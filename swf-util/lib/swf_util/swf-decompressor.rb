$:.unshift File.join(File.dirname(__FILE__),".")
require 'zlib'
module SwfUtil
  class SWFDecompressor<SWFCompression 
    def initialize(from=nil,to=nil)
      read_file(from,to) if !from.nil? and !to.nil?
    end
    def read_file(file,to) 
      swf=nil
      File.open(file,"r") do |f|
        swf=f.read(read_full_size(file))
      end
      decomp=uncompress(swf)
      File.open(to,"w+") do |f|
        f.write(decomp)
      end  
    end
    def uncompress(bytes)
      decompressor =Zlib::Inflate.new
      swf=decompressor.inflate(strip(bytes))
      swf=bytes[0,8]+swf
      swf[0] = 70
      swf
    end
  end
end
