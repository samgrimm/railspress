class ImagesController < ApplicationController
  before_action :load_widgetable
  before_action :set_widget

  def create
    @widget = @widgetable.widgets.build(widget_params)
    @widget.type = 'Image'
    if @widget.save
      redirect_to website_page_path(@widgetable.website, @widgetable, locale: I18n.locale)
    end
  end

  def edit; end

  def update
    if @widget.update(widget_params)
      redirect_to website_page_path(@widgetable.website, @widgetable, locale: I18n.locale), notice: t('.widget_updated')
    else
      render :edit
    end
  end

  def destroy
    @widget.destroy
    redirect_to website_page_path(@widgetable.website, @widgetable, locale: I18n.locale), notice: t('.widget_destroyed')
  end

  def sort
    params[:order].each do |_key, value|
      @widgetable.widgets.find(value[:id]).update(position: value[:position])
    end
    render nothing: true
  end

  private

  def set_widget
    @widget = Widget.find(params[:id])
  end

  def widget_params
    params.require(:image).permit(:title, :image, :type, :col_span)
  end

  def load_widgetable
    resource = request.path.split('/')[4]
    id = request.path.split('/')[5]
    @widgetable = resource.singularize.classify.constantize.find(id)
  end
end
