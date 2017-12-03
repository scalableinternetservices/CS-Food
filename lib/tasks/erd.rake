desc 'Generate Entity Relationship Diagram'
task :generate_erd do
  system "erd --notation=crowsfoot --inheritance --cluster --filetype=dot --prepend_primary=true --attributes=primary_keys,foreign_keys,content"
  system "dot -Tpng erd.dot > erd.png"
  File.delete('erd.dot')
end
