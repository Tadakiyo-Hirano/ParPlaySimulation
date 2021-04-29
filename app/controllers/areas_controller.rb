class AreasController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)

  def index
    @areas = Area.all.order(:id).group_by(&:district)
  end

  def edits
    @areas = Area.all.order(:id)
  end

  def updates
    @areas = areas_params.each do |id, area_param|
      area= Area.find(id)
      area.update_attributes(area_param)
      area
    end
    flash[:info] = "地域を更新しました。"
    redirect_to areas_url
  end

  private

    def set_area
      @area = Area.find(params[:id])
    end

    def areas_params
      params.permit(areas: [:district])[:areas]
    end
end
