class AdminController < ApplicationController
  def sign_up
    @admin = Admin.new
  end

  def sign_in
    if request.post?
      admin = Admin.find_by(email: params[:email])
      if admin && admin.authenticate(params[:password])
        session[:admin_id] = admin.id
        redirect_to root_path, notice: "Logged in successfully"
      else
        flash.now[:alert] = "Invalid email or password"
        render :new
      end
    end
  end

end