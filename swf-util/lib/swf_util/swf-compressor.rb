$:.unshift File.join(File.dirname(__FILE__),".")
require 'zlib'
module SwfUtil
  class SWFCompressor < SWFCompression
    def initialize(from=nil,to=nil)
      read_file(from,to) if !from.nil? and !to.nil?
    end
    def read_file(file,to)
      buff = nil
      File.open(file,"rb") do |fin|
        buff = fin.read
      end
      temp=compress(buff)
      File.open(to,"wb") do |fout|
        fout.write(temp)
      end
    end
    def compress(buffer)
      compressor=Zlib::Deflate.new
      data=compressor.deflate(strip(buffer),Zlib::FINISH)
      data=buffer[0,8]+data
      data[0]=67
      return data
    end
  end
end

