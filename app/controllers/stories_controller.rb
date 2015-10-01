# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

class StoriesController < ApplicationController
  # FIXME : removed auth for now
  # before_action :authenticate_user!, except: [:show]
  respond_to :html, :json
  
  def show
    # FIXME: Naive implementation, will create bad ids!
    @story    = Story.find_or_create_by(user_set_id: params[:id])
    @records  = @story.user_set.items
    @search   = search(params[:search])
  end

  def index
    @stories = Story.all
    @communities = Community.all
  end

  def create
    # if params[:user_set].nil?
    #   render nothing: true, status: 500
    # end

    # user_set = current_sj_user.sets.build(params[:user_set])
    # user_set.records = [{record_id: params[:record_id]}] if params[:record_id]
    # user_set.save

    # respond_to do |format|
    #   format.html {redirect_to user_sets_path}
    #   format.js do
    #     render json: {set_id: user_set.id}.to_json
    #   end
    # end
  end

  def update
    @story    = Story.find_by(user_set_id: params[:id])
    if @story.update(params.permit(:content))
      render :json => { :status => 'ok' }
    else
      render :json => { :status => '500' }
    end
  end

  def add_community
    @story = Story.find_by(user_set_id: params[:id])
    @community = Community.find(params[:community_id])
    @story.communities << @community
    redirect_to @story
  end

end
