class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.page(params[:page]).per_page(10)
    @total = Exercise.count
  end

  def show
    @exercise = Exercise.find params[:id]
  end

  def search
    @labels = params[:labels].split(",") if params[:labels].present?
    @exclusive = params[:exclusive]

    search = Exercise.search do
      fulltext params[:query]
      with(:exclusive, true) if params[:exclusive].present?
      with(:label_ids).all_of(params[:labels].split(",")) if params[:labels].present?
      paginate page: params[:page] || 1, per_page: 10
    end

    @exercises = search.results
    @total = search.total
    render :index
  end

end
