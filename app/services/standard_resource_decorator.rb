class StandardResourceDecorator < Struct.new(:listener)
  def success(resource)
    listener.success(decorated_resource resource)
  end
  
  def failure(resource)
    listener.failure(decorated_resource resource)
  end
  
  private
    def decorated_resource(resource)
      resource.decorate
    end
end
