class Api::V1::RemindersController < ApplicationController
  before_action :authorize_request
  before_action :find_reminder, except: %i[create index summary]

  # GET /reminders
  def index
    @reminders = Reminder.where(filter_params)
    render json: @reminders, each_serializer: ReminderSerializer, params: params[:include]
  end

  # GET /reminders/summary
  def summary
    @reminders = Reminder.where(filter_params)

    @reminders.map do |reminder|
      reminder.paid = Transaction.where(date: params[:from]..params[:to]).where(reminder_id: reminder.id).exists?
    end

    render json: @reminders, each_serializer: ReminderSerializer, params: params[:include]
  end


  # GET /reminders/{id}
  def show
    render json: @reminder, serializer: ReminderSerializer, params: params[:include]
  end
  

  # POST /reminders
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user_id = @current_user.id

    if @reminder.save
      render json: @reminder, status: :created
    else
      render json: { errors: @reminder.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /reminders/{id}
  def update
    unless @reminder.update(reminder_params)
      render json: { errors: @reminder.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /reminders/{id}
  def destroy
    @reminder.destroy
  end

  private

  def find_reminder
    @reminder = Reminder.find_by_id!(params[:id])

  if !@reminder || !is_reminder_owner
      ActiveRecord::RecordNotFound
    end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Lembrete não encontrado' }, status: :not_found
  end

  def is_reminder_owner
    is_admin || @reminder.user_id == @current_user.id
  end

  def reminder_params
    params.permit( :name, :description, :icon, :color, :monthly_limit, :status)
  end

  def filter_params
    permitted_params = params.permit!.except(:controller, :action, :include, :category_ids, :from, :to)

    if params[:category_ids].present?
      category_ids = params[:category_ids].split(",").map(&:to_i)
      permitted_params[:category_id] = category_ids
    end

    !is_admin ? permitted_params.merge(user_id: @current_user.id) : permitted_params
  end
  
end
