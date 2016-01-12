swf util is a lightweight tool to read swf header、compress/decompress swf for Ruby.It is implemented in pure ruby.

Example:
  * read swf'sheader

```
require 'rubygems'
require 'swfheader'
header=SwfUtil.read_header("test.swf")

header.inspect

header.version

header.frame_rate

header.width
...

```

  * compress swf file
```
   SwfUtil::compress_swf("test.swf","test_compressed.swf")
```

  * Decompress swf file
```
  SwfUtil::decompress_swf("test_compressed.swf","test_decompressed.swf")
```
