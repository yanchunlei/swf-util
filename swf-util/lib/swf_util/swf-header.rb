$:.unshift File.join(File.dirname(__FILE__),".")
module SwfUtil
  class SWFHeader < SWFCompression
    def initialize(file)
      parse_header(file)
    end
    attr_accessor :signature,:compression_type,:version,:size,:nbits,:xmax,:ymax,:width,:height,:frame_rate,:frame_count,
    COMPRESSED   = "compressed"
    UNCOMPRESSED = "uncompressed"
    def parse_header(file)
      temp=nil
      @size=read_full_size(file)
      File.open(file,"r") do |f|
        temp=f.read(@size)
      end
      if !is_swf?(temp)
        raise RuntimeError.new,"File does not appear to be a swf",caller
      else
        @signature=temp[0,3]
      end
      if is_compressed?(temp[0])
        temp=SWFDecompressor.new.uncompress(temp)
        @compression_type=COMPRESSED
      else
        @compression_type=UNCOMPRESSED
      end
      @version=temp[3]
      @nbits = ((temp[8]&0xff)>>3)
      pbo = read_packed_bits( temp, 8, 5, @nbits ) 
      pbo2 = read_packed_bits( temp, pbo.nextByteIndex,pbo.nextBitIndex, @nbits ) 
      
      pbo3 = read_packed_bits( temp, pbo2.nextByteIndex,pbo2.nextBitIndex, @nbits ) 
      
      pbo4 = read_packed_bits( temp, pbo3.nextByteIndex,pbo3.nextBitIndex, @nbits ) 
      @xmax = pbo2.value
      @ymax = pbo4.value 
      
      @width = convert_twips_to_pixels( @xmax ) 
      @height = convert_twips_to_pixels( @ymax ) 
      
      bytePointer = pbo4.nextByteIndex + 2 
      
      @frame_rate = temp[bytePointer]
      bytePointer+=1
      fc1 = temp[bytePointer] & 0xFF
      bytePointer+=1
      
      fc2 = temp[bytePointer] & 0xFF
      bytePointer+=1
      @frame_count=(fc2 <<8)+fc1 
      temp=nil
    end
    def is_swf?(bytes)
      bytes[0,3]=="FWS" or bytes[0,3]=="CWS"
    end
    def is_compressed?(first_byte)
      if first_byte==67
        return true
      else
        return false
      end
    end
    def read_packed_bits(bytes,byteMarker,bitMarker,length)
      total = 0
      shift = 7 - bitMarker 
      counter = 0 
      bitIndex = bitMarker 
      byteIndex = byteMarker 
      while counter<length
       (bitMarker...8).each do |i|
          bit =((bytes[byteMarker] & 0xff ) >> shift ) & 1 
          total = ( total << 1 ) + bit 
          bitIndex = i 
          shift-=1 
          counter+=1 
          if counter==length
            break 
          end
        end
        byteIndex = byteMarker 
        byteMarker+=1
        bitMarker = 0 
        shift = 7 
      end
      return PackedBitObj.new(bitIndex, byteIndex, total ) 
    end
    def  convert_twips_to_pixels(twips)
      twips / 20 
    end
    def convert_pixels_to_twips( pixels )
      return pixels * 20 
    end
    def inspect
      "signature:   "+@signature.to_s+"\n"+
      "version:     "+@version.to_s+"\n"+
      "compression: "+@compression_type.to_s+"\n"+
      "size:        "+@size.to_s+"\n"+
      "nbits:       "+@nbits.to_s+"\n"+
      "xmax:        "+@xmax.to_s+"\n"+
      "ymax:        "+@ymax.to_s+"\n"+
      "width:       "+@width.to_s+"\n"+
      "height:      "+@height.to_s+"\n"+
      "frameRate:   "+@frame_rate.to_s+"\n"+
      "frameCount:  "+@frame_count.to_s+"\n"
    end
  end
end

