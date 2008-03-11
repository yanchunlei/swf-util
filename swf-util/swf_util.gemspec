#swf_util.spec
require 'rubygems'
SPEC=Gem::Specification.new do |s|
  s.name="SwfUtil"
  s.version='0.01'
  s.author='Dennis Zane'
  s.email="killme2008@gmail.com"
  s.homepage="http://www.blogjava.net/killme2008"
  s.platform=Gem::Platform::RUBY
  s.summary="a light weight tool for read swf header,compress/decompress swf for Ruby"
  s.files=Dir.glob("{lib,test}/**/*")
  s.require_path="lib"
  s.autorequire='swf_util'
  s.test_file="test/test.rb"
  s.has_rdoc=false
  s.extra_rdoc_files=["README"]
end  