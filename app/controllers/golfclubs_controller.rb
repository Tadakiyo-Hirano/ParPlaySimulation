class GolfclubsController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)
  before_action :admin_user, only: %i(index new create edit update destroy)
  before_action :set_golfclub, only: %i(show edit update destroy)

  def index
    @q = Golfclub.ransack(params[:q])
    @golfclubs = @q.result(distinct: true).order(:id)
    # @golfclubs = Golfclub.all
  end

  def show
    @courses = @golfclub.courses
  end

  def new
    @golfclub = Golfclub.new
    @courses = @golfclub.courses.build
  end

  def create
    @golfclub = Golfclub.new(golfclub_params)
    if @golfclub.save
      redirect_to golfclub_url(@golfclub), flash: { success: "#{@golfclub.name}を登録しました。" }
    else
      flash[:danger] = @golfclub.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end

  def edit
  end

  def update
    if @golfclub.update(golfclub_params)
      redirect_to golfclubs_url, flash: { success: "#{@golfclub.name}を更新しました。" }
    else
      flash[:danger] = @golfclub.errors.full_messages.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @golfclub.destroy
    redirect_to golfclubs_url, flash: { success: "#{@golfclub.name}を削除しました。" }
  end

  private

    def set_golfclub
      @golfclub = Golfclub.find(params[:id])
    end

    def golfclub_params
      params.require(:golfclub).permit(:name, :home_page_url, :strategy_video, :area_id, :photo)
    end
end
