class WeightsController < ApplicationController

	def index
		@weights = Weight.most_recent_by_date
		# @weights = Weight.most_recent_by_date.page(params[:page]).per(params[:per])
    respond_to do |format|
      format.js
      format.html
    end    	
	end

  def new
    @new_weight = Weight.new
  end

	def create
		@weights = Weight.most_recent_by_date		
		# @weights = Weight.most_recent_by_date.page(params[:page]).per(params[:per])
		@new_weight = Weight.new(weight_params)
		if @new_weight.save
      respond_to do |format|
        format.js { render json: { data: @new_weight} }
        format.html { redirect_to weights_path }
      end 
    else
      respond_to do |format|
        format.js {render plain: '0'}
        format.html { render :new }
      end
    end
  end

	def show
    @weight = Weight.find(params[:id])
  end

  def edit
    @weight = Weight.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @weight = Weight.find(params[:id])
    if @weight.update(weight_params)
      respond_to do |format|
        format.js { render json: { data: @weight} }        
        format.html { redirect_to weights_path }
      end
    else
      respond_to do |format|
        format.js
        format.html { render :edit}
      end
    end
  end

  def destroy
    @weight = Weight.find(params[:id])
    @id = @weight.id
    if @weight.destroy
      respond_to do |format|
        format.js {render plain: '1'}
        format.html {redirect_to weights_path}
      end
    else
      respond_to do |format|
        format.js {render plain: "0"}
        format.html {render :back}
      end
    end
  end

  def filter
    filter_type = params[:filter][:type]
    case filter_type
    when "last_seven"
      @filter = "1W"
      @filtered_runs = Weight.in_the_last_week
    when "last_thirty"
      @filter = "1M"
      @filtered_runs = Weight.in_the_last_thirty_days
    when "last_ninety"
      @filter = "3M"
      @filtered_runs = Weight.in_the_last_ninety_days
  	end  

  	respond_to do |format|
      format.js
    end

  end    

	private

	def weight_params
		params.require(:weight).permit(:weight_date, :weight_time, :weight)
	end

  def filter_params
    params.require(:filter).permit(:type)
  end

end