 class UsersController < ApplicationController
   before_action :authenticate_user!
   load_and_authorize_resource
 #   before_action :set_user, only[:show, :edit, :update]
#
#   def index
#     @users = User.all
#   end
#
   def show
     # raise params.inspect
     # raise current_user.inspect
     @user = User.find(params[:id])
     authorize! :read, @user.id
      # raise @user.inspect
     # authorize! :read, @user
     # unless current_user.id == @user.id
     #   redirect_to root_path, :alert => "Access denied."
     # end

   end


#   def edit; end
#
#   def update
#     respond_to do |format|
#       if @user.update(user_prams)
#         format.html {
#           redirect_to @user,
#                       notice:
#                         'User was
#                       successfully updated.'
#         }
#         format.json {
#           render :show,
#                  status: :ok,
#                  location: @user
#         }
#       else
#         format.html {
#           render :edit
#         }
#         format.json {
#           render json: @user.errors,
#                  status: :unprocessable_entity
#         }
#       end
#     end
#   end
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_user
#     @user = User.find(params[:id])
#   end
#
#   # Never trust parameters from the scary internet, only allow the white list through.
#   def user_params
#     params.require(:user).permit(
#       :role,
#       :user_name
#     )
#   end
#
#
end
