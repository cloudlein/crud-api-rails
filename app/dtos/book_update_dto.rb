# frozen_string_literal: true

class BookUpdateDTO
  include ActiveModel::Model

  attr_accessor :id, :title, :author_id, :genre_ids

  validates :id, numericality: { only_integer: true }, presence: true
  validates :title, length: { minimum: 3 }, presence: true
  validates :author_id, numericality: { only_integer: true }, allow_nil: true


  validate :author_must_exists
  validate :genre_must_exists

  def author_must_exists
    return if author_id.blank?
    errors.add(:author_id, "is invalid or does not exist") unless Author.exists?(author_id)
  end

  def genre_must_exists
    return if genre_ids.blank?

    count = Genre.where(id: genre_ids).count
    errors.add(:genre_ids, "is invalid or does not exist") unless count == genre_ids.uniq.count
  end
end
