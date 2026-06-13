class BookQuery
  SORTABLE_COLUMNS  = %w[title created_at].freeze
  SORT_DIRECTIONS   = %w[asc desc].freeze
  DEFAULT_SORT_BY   = "created_at"
  DEFAULT_SORT_DIR  = "asc"


  def initialize(params = {})
    @params   = params
    @relation = build_base_relation
  end

  def call
    @relation
      .includes(:author, :genres)
      .then { |r| filter_by_title(r) }
      .then { |r| sort(r) }
  end

  private

  def build_base_relation
    if @params[:author_id]
      Author.find(@params[:author_id]).books
    elsif @params[:genre_id]
      Genre.find(@params[:genre_id]).books
    else
      Book.all
    end
  end

  # Filter: WHERE title ILIKE '%keyword%'
  def filter_by_title(relation)
    return relation if @params[:title].blank?
    keyword = "%#{@params[:title].strip}%"
    relation.where("title ILIKE ?", keyword)
  end

  # Sort: ORDER BY <column> <direction>
  def sort(relation)
    column    = SORTABLE_COLUMNS.include?(@params[:sort_by])  ? @params[:sort_by]  : DEFAULT_SORT_BY
    direction = SORT_DIRECTIONS.include?(@params[:sort_dir])  ? @params[:sort_dir] : DEFAULT_SORT_DIR

    relation.order(column => direction)
  end
end

