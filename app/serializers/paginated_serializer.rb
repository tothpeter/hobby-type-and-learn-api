class PaginatedSerializer < ActiveModel::Serializer::ArraySerializer
  def initialize(object, options = {})
    meta_key = options[:meta_key] || :meta

    options[meta_key] ||= {}
    options[meta_key].merge!({
          "current-page": object.current_page,
          "next-page": object.next_page,
          "prev-page": object.prev_page,
          "total-pages": object.total_pages,
          "total-count": object.total_count
        })
    super(object, options)
  end
end