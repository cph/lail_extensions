module AssetsHelper 
  
  
  def include_stylesheet_dir( path, options={} )
    css_path = options[:path] || "stylesheets"
    stylesheets = Dir.glob_in(File.join(RAILS_ROOT, "public", css_path, path), "*.css")
    if (order=options[:order])
      order = order.map{|s| "#{s}.css"}
      stylesheets = ((order & stylesheets) + (stylesheets - order))
    end
    stylesheets = stylesheets.map{|file| File.join("/#{css_path}", path, file)}
    stylesheet_link_tag *(stylesheets + [{:cache => "#{path}/concat"}.merge(options.pick(:media))])
  end


  def include_javascript_dir( path, options={} )
    js_path = options[:path] || "javascripts"
    javascripts = Dir.glob_in(File.join(RAILS_ROOT, "public", js_path, path), "*.js")
    if (order=options[:order])
      order = order.map{|s| "#{s}.js"}
      javascripts = ((order & javascripts) + (javascripts - order))
    end
    javascripts = javascripts.map{|file| File.join("/#{js_path}", path, file)}
    javascript_include_tag *(javascripts + [{:cache => "#{path}/concat"}.merge(options.pick(:media))])
  end


end 


class Dir

  def Dir.glob_in(path, *args)
    original_dir = Dir.pwd
    begin
      Dir.chdir(path)
      return Dir.glob(*args)
    ensure
      Dir.chdir(original_dir)
    end
  end

end