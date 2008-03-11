$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'swf_util'
#read swf header
puts SwfUtil::read_header(File.join(File.dirname(__FILE__),".","test.swf")).inspect

#decompress swf
SwfUtil::decompress_swf(File.join(File.dirname(__FILE__),".","test.swf"),
                   File.join(File.dirname(__FILE__),".","test2.swf"))
#compress swf
SwfUtil::compress_swf(File.join(File.dirname(__FILE__),".","test2.swf"),
                   File.join(File.dirname(__FILE__),".","test3.swf"))