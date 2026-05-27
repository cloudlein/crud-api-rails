class AuthorQuery
  SORTABLE_COLUMNS  = %w[first_name last_name pen_name created_at nationality].freeze
  SORT_DIRECTIONS   = %w[asc desc].freeze
  DEFAULT_SORT_BY   = "created_at"
  DEFAULT_SORT_DIR  = "asc"


  def initialize(relation = Author.all, params = {})
    @relation = relation
    @params   = params
  end

  def call
    @relation
      .includes(:books)
      .then { |r| filter_by_name(r) }
      .then { |r| sort(r) }
  end

  private

  # Filter: WHERE name ILIKE '%keyword%'
  # ILIKE adalah case-insensitive LIKE di PostgreSQL
  def filter_by_name(relation)
    return relation if @params[:name].blank?
    keyword = "%#{@params[:name].strip}%"
    relation.where(
      "first_name ILIKE ? OR last_name ILIKE ? OR pen_name ILIKE ?",
      keyword, keyword, keyword
    )
  end

  # Sort: ORDER BY <column> <direction>
  # Whitelist kolom & arah untuk mencegah SQL injection
  def sort(relation)
    column    = SORTABLE_COLUMNS.include?(@params[:sort_by])  ? @params[:sort_by]  : DEFAULT_SORT_BY
    direction = SORT_DIRECTIONS.include?(@params[:sort_dir])  ? @params[:sort_dir] : DEFAULT_SORT_DIR

    relation.order(column => direction)
  end
end