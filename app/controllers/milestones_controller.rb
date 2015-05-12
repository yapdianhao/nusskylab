class MilestonesController < ApplicationController
  layout 'admins'

  def index
    not check_access(true, true) and return
    @milestones = Milestone.all
  end

  def new
    not check_access(true, true) and return
    @milestone = Milestone.new
  end

  def create
    not check_access(true, true) and return
    test = Milestone.new(get_milestone_params)
    @milestone = Milestone.new(:name => test.name, :deadline => test.deadline)
    if @milestone.save
      flash = {}
      flash[:success] = 'The milestone is successfully created'
      redirect_to milestones_path, flash: flash
    else
      render 'new'
    end
  end

  def show
    not check_access(true, true) and return
    @milestone = Milestone.find(params[:id])
  end

  def edit
    not check_access(true, true) and return
    @milestone = Milestone.find(params[:id])
  end

  def update
    not check_access(true, true) and return
    @milestone = Milestone.find(params[:id])
    if @milestone.update(get_milestone_params)
      flash = {}
      flash[:success] = 'The milestone is successfully edited'
      redirect_to milestones_path, flash: flash
    else
      render 'edit'
    end
  end

  def destroy
    not check_access(true, true) and return
    @milestone = Milestone.find(params[:id])
    @milestone.destroy
    flash = {}
    flash[:success] = 'The milestone is successfully deleted'
    redirect_to milestones_path, flash: flash
  end

  private
    def get_milestone_params
      params.require(:milestone).permit(:name, :deadline)
    end
end
