module GenerateTagRSS
  class TagRSSGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.tags.each do |tag, posts|
        Jekyll.logger.info "\tGenerating feed for tag: #{tag}"
        site.pages << TagRSSPage.new(site, tag, posts)
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class TagRSSPage < Jekyll::Page
    def initialize(site, tag, posts)
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @dir  = 'blorg/feeds-gen'    # the directory the page will reside in.

      @basename = tag          # filename without the extension.
      @ext      = '.xml'       # the extension.
      @name     = tag + '.xml' # basically @basename + @ext.


      # Initialize data hash with a key pointing to all posts under current category.
      # This allows accessing the list in a template via `page.linked_docs`.
      @data = {
        'linked_docs' => posts
      }

      # Look up front matter defaults scoped to type `tags`, if given key
      # doesn't exist in the `data` hash.
      data.default_proc = proc do |_, key|
        site.frontmatter_defaults.find(relative_path, :tag, key)
      end
    end

    # Placeholders that are used in constructing page URL.
    def url_placeholders
      {
        # :tag        => @dir,
        :path       => @dir,
        :basename   => basename,
        :output_ext => output_ext,
      }
    end
  end
end
