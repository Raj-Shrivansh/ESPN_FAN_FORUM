class MessageController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @messages=Message.all.order("created_at DESC")
    end
    def show
        @message=Message.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        flash[:error]="This message does not exist."
        redirect_to  messages_path
    end
    def new
        @message=current_user.messages.build
    end
    def create
        @message=current_user.messages.build(message_params)
        if @message.save
            flash[:notice]='Message Post Successfully'
            redirect_to message_index_path
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
        @message=Message.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            flash[:error]="With given Id Message not found"
            redirect_to message_index_path
        end
    def update
        @message=Message.find(params[:id])
        if @message.update(message_params)
            flash[:notice]= "Post has been updated successfully!"
            redirect_to message_index_path
        else
            render :edit, status: :unprocessable_entity
        end
    end
    def destroy
        @message=Message.find(params[:id])
        @message.delete
        flash[:notice]="Message Deleted Successfully"
        rescue ActiveRecord::RecordNotFound
            redirect_to  message_index_path
        end
    private
    def message_params
        params.require(:message).permit(:title,:desc)
    end
end
