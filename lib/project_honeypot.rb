module ProjectHoneypot
  def lookup(api_key, url)
    searcher = Base.new(api_key)
    searcher.lookup(url)
  end
end