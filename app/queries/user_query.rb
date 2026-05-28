class UserQuery
  SORTABLE_COLUMNS  = %w[name email created_at].freeze
  SORT_DIRECTIONS   = %w[asc desc].freeze
  DEFAULT_SORT_BY   = "created_at"
  DEFAULT_SORT_DIR  = "asc"

  def initialize(relation = User.all, params = {})
    @relation = relation
    @params   = params
  end

  def call
    @relation
      .then { |r| filter_by_name(r) }
      .then { |r| filter_by_email(r) }
      .then { |r| filter_by_role(r) }
      .then { |r| sort(r) }
  end

  private

  def filter_by_name(relation)
    return relation if @params[:name].blank?
    keyword = "%#{@params[:name].strip}%"
    relation.where("name ILIKE ?", keyword)
  end

  def filter_by_email(relation)
    return relation if @params[:email].blank?
    keyword = "%#{@params[:email].strip}%"
    relation.where("email ILIKE ?", keyword)
  end

  def filter_by_role(relation)
    return relation if @params[:role].blank?
    relation.where("role = ?", @params[:role])
  end

  def sort(relation)
    column    = SORTABLE_COLUMNS.include?(@params[:sort_by])  ? @params[:sort_by]  : DEFAULT_SORT_BY
    direction = SORT_DIRECTIONS.include?(@params[:sort_dir])  ? @params[:sort_dir] : DEFAULT_SORT_DIR

    relation.order(column => direction)
  end
end