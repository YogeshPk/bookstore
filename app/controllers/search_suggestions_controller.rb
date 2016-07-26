class SearchSuggestionsController < ApplicationController
   def index
      render json: SearchSuggestion.terms_for(params[:term])
   end
   def self.update_search(suggestion)
     suggestion.popularity += 1
     suggestion.update(searchsuggestion_params)
   end
   private
   # Never trust parameters from the scary internet, only allow the white list through.
    def searchsuggestion_params
      params.require(:searchsuggestion).permit(:term, :popularity)
    end
 end
