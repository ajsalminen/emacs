#!/usr/bin/env ruby

## Hope to god this is licensed for usage
## http://d.hatena.ne.jp/eiel/20090111#1231681381


def make_key(key)
  head = key.clone
  key.tr!('A-Z', 'a-z')
  key.sub!(/\s+/, ' ')
#  key.sub!(/ \+\d+/, '')        # これなんの処理だろ？
  ret = "" 
  if head != key
    ret = "<H>#{head}</H>"
  end
  ret + "<K>#{key}</K>"
end

ARGF.each do |line|
  line.gsub!('&', '&amp;')
  line.gsub!('<', '&lt;')
  line.gsub!('>', '&gt;')
  line.gsub!(' \ ', '&lf;  ')
  key, content  = line.split(' : ')
  puts make_key(key) + content.chomp
end