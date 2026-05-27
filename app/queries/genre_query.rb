# frozen_string_literal: true

# Query Object untuk Genre.
#
# Memisahkan logika filter & sort dari controller, sehingga controller
# tidak perlu tahu detail implementasi query-nya.
#
# Penggunaan:
#   GenreQuery.new(Genre.all, params).call
#   GenreQuery.new(author.genres, params).call  ← bisa menerima relation apapun
#
# Params yang didukung:
#   ?name=action        → filter nama genre (case-insensitive, partial match)
#   ?sort_by=name       → kolom sort: "name" | "created_at" (default: "name")
#   ?sort_dir=desc      → arah sort: "asc" | "desc" (default: "asc")
#
class GenreQuery
  SORTABLE_COLUMNS  = %w[name created_at].freeze
  SORT_DIRECTIONS   = %w[asc desc].freeze
  DEFAULT_SORT_BY   = "name"
  DEFAULT_SORT_DIR  = "asc"

  def initialize(relation = Genre.all, params = {})
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

    relation.where("name ILIKE ?", "%#{@params[:name].strip}%")
  end

  # Sort: ORDER BY <column> <direction>
  # Whitelist kolom & arah untuk mencegah SQL injection
  def sort(relation)
    column    = SORTABLE_COLUMNS.include?(@params[:sort_by])  ? @params[:sort_by]  : DEFAULT_SORT_BY
    direction = SORT_DIRECTIONS.include?(@params[:sort_dir])  ? @params[:sort_dir] : DEFAULT_SORT_DIR

    relation.order(column => direction)
  end
end
