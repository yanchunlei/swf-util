require 'bit-struct'
module SwfUtil
  class SWFCompression
    def read_full_size(file)
      buff = nil
      File.open(file,"rb") do |f|
        f.seek(4,IO::SEEK_CUR)
        buff = f.read 4
      end
      return read_size(buff)
    end
    def read_size(buff)
      buff=buff.reverse
      size=Size.new(buff).value
    end
    def strip(bytes)
      bytes[8,bytes.size-8]
    end
  end
  class Size<BitStruct
    unsigned :value,32
  end
end

