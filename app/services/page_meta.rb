class PageMeta
  def initialize()

  end

  def facebook_enabled=(value)
    @facebook_enabled = value
  end

  def facebook?
    @facebook_enabled == true
  end

  def facebook_og_


    # <meta property="fb:app_id" content="123456789">
    # <meta property="og:url" content="https://example.com/page.html">
    # <meta property="og:type" content="website">
    # <meta property="og:title" content="Content Title">
    # <meta property="og:image" content="https://example.com/image.jpg">
    # <meta property="og:image:alt" content="A description of what is in the image (not a caption)">
    # <meta property="og:description" content="Description Here">
    # <meta property="og:site_name" content="Site Name">
    # <meta property="og:locale" content="en_US">
    # <meta property="article:author" content="">
  end
end
