class ImagesController < ApplicationController
  before_action :load_widgetable

  def create
    @widget = @widgetable.widgets.build(widget_params)
    @widget.type = 'Image'
    if @widget.save
      redirect_to website_page_path(@widgetable.website, @widgetable, locale: I18n.locale)
    end
  end


  def sort
    params[:order].each do |key, value|
      @widgetable.widgets.find(value[:id]).update(position: value[:position])
    end
    render nothing: true
  end

  private

  def widget_params
    params.require(:widget).permit(:title, :image, :type, :col_span )
  end

  def load_widgetable
    resource = request.path.split('/')[4]
    id = request.path.split('/')[5]
    @widgetable = resource.singularize.classify.constantize.find(id)
  end

end
