class TodosController < ApplicationController

  def index
    @todos = Todo.all
    respond_to do |format|
      format.json { render json: @todos }
    end
  end

  def create
    @todo = Todo.create(todo_params)
    respond_to do |format|
      format.json
    end
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(todo_params)
    respond_to do |format|
      format.json
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    respond_to do |format|
      format.json
    end
  end
end
