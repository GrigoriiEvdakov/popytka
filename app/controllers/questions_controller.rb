# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show destroy edit update]

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate
    # Question.order(created_at: :desc).page params[:page]
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate
    # @question.answers.order(created_at: :desc).page(params[:page]).per(7)
    # Answer.where(question: @question).order created_at: :desc
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:succes] = 'Question created!'
      redirect_to questions_path
    else
      render :new
    end
  end

  def update
    if @question.update question_params
      flash[:succes] = 'Question updated!'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:succes] = 'Question deleted!'
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end
end
