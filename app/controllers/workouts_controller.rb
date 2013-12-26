# WorkoutsController is responsible for displaying member workouts.
class WorkoutsController < ApplicationController
  def show
    @view = Workouts::Show.new(self, current_user, params[:id])
  end
end
