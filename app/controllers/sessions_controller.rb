class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = JWT.encode({ id: resource.id, email: resource.email }, ENV["DEVISE_JWT_SECRET_KEY"])
    render json: {
      token: token,
      user: resource
    }
  end

  def respond_to_on_destroy
    head :no_content
  end
end
