class SearchSuggestion < ApplicationRecord
  #attr_accessible :popularity , :term

  def self.terms_for(prefix)
    suggestions = where("term like ?", "#{prefix}_%")
    suggestions.order("popularity DESC").limit(10).pluck(:term)
  end

  def self.index_books
    Book.find_each do |book|
      index_term(book.name)
      book.name.split.each {|t| index_term(t)}
    end
  end

  def self.index_term(term)
    suggest = SearchSuggestion.where("term = ?",term)
    if suggest.empty?
      @term = SearchSuggestion.new(:term => term,:popularity => 1)
      @term.save
    else
      #find solution to update popularity.
    end

  end
end
