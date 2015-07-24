class ArticlePresenter < BasePresenter
  presents :article

  def id
    article.id
  end

  def class_name
    article.class.name.downcase
  end

  def title
    article.title
  end

  def linked_title(options = {})
    h.link_to article.title, article, options
  end

  def date(format = :long)
    h.content_tag :span, class: 'date' do
      h.l article.date, format: format
    end
  end

  def linked_category
    h.link_to article.article_category, title: article.article_category.title do
      h.content_tag :span, class: 'article-category' do
        article.article_category.title
      end
    end
  end

  def summary
    h.raw article.summary
  end

  def content
    h.raw article.content
  end

  def image
    h.image_tag article.image.show, alt: article.title, id: "article-image-#{id}", class: 'page-image image-right' if article.image?
  end

  def linked_index_image
    h.link_to article, title: article.title do
      if article.image?
        h.image_tag article.image.homepage, alt: article.title
      else
        h.image_tag 'placeholders/list-image.jpg', alt: article.title
      end
    end
  end

  def linked_home_image
    h.link_to article, title: article.title do
      if article.image?
        h.image_tag article.image.homepage, alt: article.title
      else
        h.image_tag 'placeholders/home-slider.jpg', alt: article.title
      end
    end
  end

  def read_more
    h.link_to 'Read more', article, class: 'content-box-ghost-button'
  end
end
