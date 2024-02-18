class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_message, only: [:create,:update,:edit,:destroy]
    before_action :find_comment, only: [:edit,:update,:destroy]
    def create
        @message=Message.find(params[:message_id])
        @comment=@message.comments.create(comment_parmas)
        @comment.user_id=current_user.id

        if @comment.save
            redirect_to message_path(@message)
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
    end
    def update
        if @comment.update(comment_parmas)
            redirect_to message_path(@message)
        else
            render :edit,status: :unprocessable_entity
        end
    end
    def destroy
        @comment.destroy
        redirect_to message_path(@message)
    end
    private
    def comment_parmas
        params.require(:comment).permit(:content)
    end
    def find_message
        @message=Message.find(params[:message_id])
    end
    def find_comment
        @comment=@message.comments.find(params[:id])

    end
end