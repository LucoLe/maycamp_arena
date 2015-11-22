class Admin::ContestGroupsController < ApplicationController
  def index
    authorize :contest_groups, :index?

    @contest_groups = ContestGroup.paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def new
    authorize :contest_groups, :new?

    @contest_group = ContestGroup.new
  end

  def create
    authorize :contest_groups, :create?

    @contest_group = ContestGroup.new(params.require(:contest_group).permit!)

    if @contest_group.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def edit
    authorize contest_group
  end

  def update
    authorize contest_group
    contest_group.attributes = params.require(:contest_group).permit!

    if contest_group.save
      flash[:notice] = "Групата е обновена успешно."
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def destroy
    authorize contest_group
    contest_group.destroy

    redirect_to :action => "index"
  end

    private

  def contest_group
    @contest_group ||= ContestGroup.find(params[:id])
  end
end
