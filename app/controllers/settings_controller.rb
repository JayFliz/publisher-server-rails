class SettingsController < ApplicationController
  before_action :set_setting, only: [:edit, :update]
  before_action :all_settings
  before_action :authorize

  def index
    @page_title = "Settings"
  end

  def show
    redirect_to settings_path
  end

  def edit
    @setting    = Setting.find(params[:id])
    @page_title = "Editing Setting : #{@setting.name}"
  end

  def update
    @setting = Setting.find(params[:id])

    # content = (
    #   @setting.name.downcase == "license" ?
    #   License.find(setting_params[:content]).short_code :
    #   @setting.content
    # )

    notice  = "Setting: was successfully updated. #{@setting.name} : #{params[:setting][:content]}"

    if @setting.update(setting_params)
      redirect_to settings_path, notice: notice
    else
      render action: "edit"
    end
  end

  private
  def set_setting
    @setting = Setting.find(params[:id])
  end

  def setting_params
    params.require(:setting).permit(:name, :key, :content)
  end

  def all_settings
    @settings = Setting.editable.all#.sort_by{ |s| s.name }
  end
end