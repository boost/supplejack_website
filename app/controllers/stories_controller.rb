# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
    @story    = Supplejack::UserSet.find(params[:id])
    @records  = @story.items
    @search   = search(params[:search])

    # FIXME Experimental!
    # https://github.com/domnikl/highscore
    @word_score = Highscore::Content.new ([@story.name, @story.description] + @records.collect{|r| r.title}).join(' ')
    @word_score.configure do
      set :ignore_case, true             # => default: false
    end
    @top_keywords = @word_score.keywords.top(3).collect{|k| k.text.downcase }.join(' OR ')
    @suggestions = Search.new(text: @top_keywords, per_page: 6)
    SearchTab.add_category_facets(@suggestions, 'Images')

  end

  def index
    sets = current_sj_user.sets.map do |set|
      {name: set.name, id: set.id, items_count: set.count}
    end

    respond_to do |format|
      format.js do
        render json: {sets: sets}
      end
    end
  end

  def create
    if params[:user_set].nil?
      render nothing: true, status: 500
    end

    user_set = current_sj_user.sets.build(params[:user_set])
    user_set.records = [{record_id: params[:record_id]}] if params[:record_id]
    user_set.save

    respond_to do |format|
      format.html {redirect_to user_sets_path}
      format.js do
        render json: {set_id: user_set.id}.to_json
      end
    end
  end
end
