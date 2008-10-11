module SwfUtil
  class SWFCompression
    def read_full_size(file)
      buff = nil
      File.open(file,"rb") do |f|
        f.seek(4,IO::SEEK_CUR)
        buff = f.read 4
      end
      return buff.unpack("L")
    end
    def strip_header(bytes)
      bytes[8,bytes.size-8]
    end
  end
end

