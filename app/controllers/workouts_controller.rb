# WorkoutsController is responsible for displaying member workouts.
class WorkoutsController < ApplicationController
  def index
    @view = Workouts::Index.new(self, params[:member_id].to_i)
  end

  def show
    @view = Workouts::Show.new(self, params[:member_id].to_i, params[:id].to_i)
  end
end
