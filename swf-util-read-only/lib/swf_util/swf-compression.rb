require 'bit-struct'
module SwfUtil
  class SWFCompression
    def read_full_size(file)
      temp=nil
      File.open(file,"r") do |f|
        f.seek(4,IO::SEEK_CUR)
        temp=f.read(4)
      end
      return read_size(temp)
    end
    def read_size(temp)
      temp=temp.reverse
      size=Size.new(temp).value
    end
    def strip(bytes)
      bytes[8,bytes.size-8]
    end
  end
  class Size<BitStruct
    unsigned :value,32
  end
end

