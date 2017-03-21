class WidgetsController < ApplicationController
  before_action :load_widgetable

  def create
    @widget = @widgetable.widgets.build(widget_params)
  end

  def sort
    params[:order].each do |_key, value|
      @widgetable.widgets.find(value[:id]).update(position: value[:position])
    end
    render nothing: true
  end

  private

  def widget_params
    params.require(:widget).permit(:title, :content, :type, :col_span)
  end

  def load_widgetable
    resource, id = request.path.split('/')[1, 2]
    @widgetable = resource.singularize.classify.constantize.find(id)
  end
end
