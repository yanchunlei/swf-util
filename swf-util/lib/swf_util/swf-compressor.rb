$:.unshift File.join(File.dirname(__FILE__),".")
require 'zlib'
module SwfUtil
  class SWFCompressor < SWFCompression
    def initialize(from=nil,to=nil)
      read_file(from,to) if !from.nil? and !to.nil?
    end
    def read_file(file,to)
      size=read_full_size(file)
      buffer=nil
      File.open(file,"r") do |fin|
        buffer=fin.read(size)
      end
      temp=compress(buffer)
      File.open(to,"w+") do |fout|
        fout.write(temp)
      end
    end
    def   compress(buffer)
      compressor=Zlib::Deflate.new
      data=compressor.deflate(strip(buffer),Zlib::FINISH)
      data=buffer[0,8]+data
      data[0]=67
      return data
    end
  end
end

