class Admin::ContestGroupsController < ApplicationController
  def index
    authorize :contests, :index?

    @contest_groups = ContestGroup.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
